define({
    /* This software is in the public domain under CC0 1.0 Universal plus a Grant of Patent License. */
    data: function() { return { notificationCount:0, messageCount:0, eventCount:0, taskCount:0, updateInterval:null, updateErrors:0 } },
    template:
    '<ul class="nav navbar-nav">' +
    '                    <li class="">' +
    '                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">' +
    '                            Overview' +
    '                            &nbsp;' +
    '                            <i class="ace-icon fa fa-angle-down bigger-110"></i>' +
    '                        </a>' +

    '                        <ul class="dropdown-menu dropdown-light-blue dropdown-caret">' +
    '                            <li>' +
    '                                <m-link href="/apps/system/Visit/VisitList">' +
    '                                    <i class="ace-icon fa fa-eye bigger-110 blue"></i>' +
    '                                    Monthly Visitors' +
    '                                </m-link>' +
    '                            </li>' +

    '                            <li>' +
    '                                <m-link href="/apps/system/Security/ActiveUsers">' +
    '                                    <i class="ace-icon fa fa-user bigger-110 blue"></i>' +
    '                                    Active Users' +
    '                                </m-link>' +
    '                            </li>' +

    '                            <li>' +
    '                                <m-link href="/apps/system">' +
    '                                    <i class="ace-icon fa fa-cog bigger-110 blue"></i>' +
    '                                    System' +
    '                                </m-link>' +
    '                            </li>' +
    '                        </ul>' +
    '                    </li>' +

    '                    <li>' +
    '                        <m-link href="/apps/my/User/Messages/FindMessage?statusId=CeReceived&toCurrentUser=true">' +
    '                            <i class="ace-icon fa fa-envelope"></i>' +
    '                            Messages' +
    '                            <span class="badge badge-warning">{{messageCount}}</span>' +
    '                        </m-link>' +
    '                    </li>' +

    '                    <li>' +
    '                        <m-link href="/apps/my/User/Task/MyTasks">' +
    '                            <i class="ace-icon fa fa-check"></i>' +
    '                            Tasks' +
    '                            <span class="badge badge-warning">{{taskCount}}</span>' +
    '                        </m-link>' +
    '                    </li>' +
    '                </ul>',
    methods: {
        updateCounts: function() {
            var lastNavDiff = Date.now() - this.$root.lastNavTime;
            if (this.updateInterval && lastNavDiff > (60*60*1000)) {
                console.log('No nav in ' + lastNavDiff + 'ms clearing updateCounts interval');
                clearInterval(this.updateInterval); this.updateInterval = null;
                return;
            }

            var vm = this; $.ajax({ type:'GET', url:(this.$root.appRootPath + '/rest/s1/mantle/my/noticeCounts'),
                dataType:'json', headers:{Accept:'application/json'},
                success: function(countObj) { if (countObj) {
                    if (countObj.notificationCount) vm.notificationCount = countObj.notificationCount;
                    if (countObj.messageCount) vm.messageCount = countObj.messageCount;
                    if (countObj.eventCount) vm.eventCount = countObj.eventCount;
                    if (countObj.taskCount) vm.taskCount = countObj.taskCount;
                    vm.updateErrors = 0;
                }},
                error: function(jqXHR, textStatus, errorThrown) {
                    vm.updateErrors++;
                    console.log('updateCounts ' + textStatus + ' (' + jqXHR.status + '), message ' + errorThrown + ', ' + vm.updateErrors + '/5 errors so far, interval id ' + vm.updateInterval);
                    if (vm.updateErrors > 4 && vm.updateInterval) { console.log('updateCounts clearing interval');
                        clearInterval(vm.updateInterval); vm.updateInterval = null; }
                }
            });
        },
        notificationListener: function(jsonObj, webSocket) {
            // TODO: improve this to look for new message, event, and task notifications and increment their counters (or others to decrement...)
            if (jsonObj && jsonObj.persistOnSend === true) this.notificationCount++;
        }
    },
    mounted: function() {
        this.updateCounts();
        this.updateInterval = setInterval(this.updateCounts, 2*60*1000); /* update every 2 minutes */
        $('.my-account-nav [data-toggle="tooltip"]').tooltip({ placement:'bottom', trigger:'hover' });
        this.$root.notificationClient.registerListener("ALL", this.notificationListener);
    }
});
