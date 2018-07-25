<#--
This software is in the public domain under CC0 1.0 Universal plus a
Grant of Patent License.

To the extent possible under law, the author(s) have dedicated all
copyright and related and neighboring rights to this software to the
public domain worldwide. This software is distributed without any
warranty.

You should have received a copy of the CC0 Public Domain Dedication
along with this software (see the LICENSE.md file). If not, see
<http://creativecommons.org/publicdomain/zero/1.0/>.
-->

<div id="apps-root">
    <input type="hidden" id="confMoquiSessionToken" value="${ec.web.sessionToken}">
    <input type="hidden" id="confAppHost" value="${ec.web.getHostName(true)}">
    <input type="hidden" id="confAppRootPath" value="${ec.web.servletContext.contextPath}">
    <input type="hidden" id="confBasePath" value="${ec.web.servletContext.contextPath}/apps">
    <input type="hidden" id="confLinkBasePath" value="${ec.web.servletContext.contextPath}/ace">
    <input type="hidden" id="confUserId" value="${ec.user.userId!''}">
    <input type="hidden" id="confLocale" value="${ec.user.locale.toLanguageTag()}">
    <#assign navbarCompList = sri.getThemeValues("STRT_HEADER_NAVBAR_COMP")>
    <#list navbarCompList! as navbarCompUrl>
        <input type="hidden" class="confNavPluginUrl" value="${navbarCompUrl}">
    </#list>

    <div id="navbar" class="navbar navbar-default    navbar-collapse       h-navbar ace-save-state">
        <div class="navbar-container ace-save-state" id="navbar-container">
            <div class="navbar-header pull-left">
                <a href="/" class="navbar-brand">
                    <small>
                        <i class="fa fa-leaf"></i>
                        Moqui
                    </small>
                </a>

                <button class="pull-right navbar-toggle navbar-toggle-img collapsed" type="button" data-toggle="collapse" data-target=".navbar-buttons,.navbar-menu">
                    <span class="sr-only">Toggle user menu</span>

                    <img src="/ace/assets/images/avatars/user.jpg" alt="Jason's Photo">
                </button>

                <button class="pull-right navbar-toggle collapsed" type="button" data-toggle="collapse" data-target="#sidebar">
                    <span class="sr-only">Toggle sidebar</span>

                    <span class="icon-bar"></span>

                    <span class="icon-bar"></span>

                    <span class="icon-bar"></span>
                </button>
            </div>

            <div class="navbar-buttons navbar-header pull-right  collapse navbar-collapse" role="navigation">
                <ul class="nav ace-nav" style="">
                    <li class="transparent dropdown-modal">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <i class="ace-icon fa fa-globe"></i>
                            ${(activeOrg.pseudoId)!}
                        </a>

                        <div class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
                            <div class="tabbable">

                                <div class="tab-content">
                                    <div id="navbar-tasks" class="tab-pane in active">
                                        <ul class="dropdown-menu-right dropdown-navbar dropdown-menu">
                                            <li class="dropdown-content ace-scroll" style="position: relative;"><div class="scroll-track" style="display: none;"><div class="scroll-bar"></div></div><div class="scroll-content" style="max-height: 200px;">
                                                <ul class="dropdown-menu dropdown-navbar">

                                                    <ul class="dropdown-menu">
                                                    <#if activeOrg?has_content>
                                                        <li><a href="${sri.buildUrl('/apps/setPrefGoLast').url}?preferenceKey=ACTIVE_ORGANIZATION&preferenceValue=">Clear Active Organization</a></li>
                                                    </#if>
                                                    <#if userOrgList?has_content><#list userOrgList as userOrg>
                                                        <li><a href="${sri.buildUrl('/apps/setPrefGoLast').url}?preferenceKey=ACTIVE_ORGANIZATION&preferenceValue=${userOrg.partyId}">${userOrg.pseudoId}: ${userOrg.organizationName}</a></li>
                                                    </#list></#if>
                                                    </ul>

                                                </ul>
                                            </div></li>

                                        </ul>
                                    </div><!-- /.tab-pane -->

                                    <div id="navbar-messages" class="tab-pane">
                                        <ul class="dropdown-menu-right dropdown-navbar dropdown-menu">
                                            <li class="dropdown-content ace-scroll" style="position: relative;"><div class="scroll-track" style="display: none;"><div class="scroll-bar"></div></div><div class="scroll-content" style="max-height: 200px;">
                                                <ul class="dropdown-menu dropdown-navbar">
                                                    <li>
                                                        <a href="#">
                                                            <img src="/ace/assets/images/avatars/avatar.png" class="msg-photo" alt="Alex's Avatar">
                                                            <span class="msg-body">
																	<span class="msg-title">
																		<span class="blue">Alex:</span>
																		Ciao sociis natoque penatibus et auctor ...
																	</span>

																	<span class="msg-time">
																		<i class="ace-icon fa fa-clock-o"></i>
																		<span>a moment ago</span>
																	</span>
																</span>
                                                        </a>
                                                    </li>

                                                    <li>
                                                        <a href="#">
                                                            <img src="/ace/assets/images/avatars/avatar3.png" class="msg-photo" alt="Susan's Avatar">
                                                            <span class="msg-body">
																	<span class="msg-title">
																		<span class="blue">Susan:</span>
																		Vestibulum id ligula porta felis euismod ...
																	</span>

																	<span class="msg-time">
																		<i class="ace-icon fa fa-clock-o"></i>
																		<span>20 minutes ago</span>
																	</span>
																</span>
                                                        </a>
                                                    </li>

                                                    <li>
                                                        <a href="#">
                                                            <img src="/ace/assets/images/avatars/avatar4.png" class="msg-photo" alt="Bob's Avatar">
                                                            <span class="msg-body">
																	<span class="msg-title">
																		<span class="blue">Bob:</span>
																		Nullam quis risus eget urna mollis ornare ...
																	</span>

																	<span class="msg-time">
																		<i class="ace-icon fa fa-clock-o"></i>
																		<span>3:15 pm</span>
																	</span>
																</span>
                                                        </a>
                                                    </li>

                                                    <li>
                                                        <a href="#">
                                                            <img src="/ace/assets/images/avatars/avatar2.png" class="msg-photo" alt="Kate's Avatar">
                                                            <span class="msg-body">
																	<span class="msg-title">
																		<span class="blue">Kate:</span>
																		Ciao sociis natoque eget urna mollis ornare ...
																	</span>

																	<span class="msg-time">
																		<i class="ace-icon fa fa-clock-o"></i>
																		<span>1:33 pm</span>
																	</span>
																</span>
                                                        </a>
                                                    </li>

                                                    <li>
                                                        <a href="#">
                                                            <img src="/ace/assets/images/avatars/avatar5.png" class="msg-photo" alt="Fred's Avatar">
                                                            <span class="msg-body">
																	<span class="msg-title">
																		<span class="blue">Fred:</span>
																		Vestibulum id penatibus et auctor  ...
																	</span>

																	<span class="msg-time">
																		<i class="ace-icon fa fa-clock-o"></i>
																		<span>10:09 am</span>
																	</span>
																</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div></li>

                                            <li class="dropdown-footer">
                                                <a href="inbox.html">
                                                    See all messages
                                                    <i class="ace-icon fa fa-arrow-right"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div><!-- /.tab-pane -->
                                </div><!-- /.tab-content -->
                            </div><!-- /.tabbable -->
                        </div><!-- /.dropdown-menu -->
                    </li>

                    <li class="light-blue dropdown-modal user-min">
                        <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                            <img class="nav-user-photo" src="/ace/assets/images/avatars/user.jpg" alt="Jason's Photo">
                            <span class="user-info">
									<small>Welcome,</small> ${(ec.user.userAccount.userFullName)!''}
								</span>

                            <i class="ace-icon fa fa-caret-down"></i>
                        </a>

                        <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                            <li>
                                <a href="/ace/my/User/Account">
                                    <i class="ace-icon fa fa-cog"></i>
                                    My Account
                                </a>
                            </li>

                            <li>
                                <a href="/ace/my/User/ContactInfo">
                                    <i class="ace-icon fa fa-user"></i>
                                    My Contact
                                </a>
                            </li>

                            <li class="divider"></li>

                            <li>
                                <a href="${sri.buildUrl("/Login/logout").url}">
                                    <i class="ace-icon fa fa-power-off"></i>
                                    Logout
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>

            <nav role="navigation" class="navbar-menu pull-left collapse navbar-collapse">
                <#--<ul class="nav navbar-nav">
                    <li class="">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                            Overview
                            &nbsp;
                            <i class="ace-icon fa fa-angle-down bigger-110"></i>
                        </a>

                        <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                            <li>
                                <a href="#">
                                    <i class="ace-icon fa fa-eye bigger-110 blue"></i>
                                    Monthly Visitors
                                </a>
                            </li>

                            <li>
                                <a href="#">
                                    <i class="ace-icon fa fa-user bigger-110 blue"></i>
                                    Active Users
                                </a>
                            </li>

                            <li>
                                <a href="#">
                                    <i class="ace-icon fa fa-cog bigger-110 blue"></i>
                                    Settings
                                </a>
                            </li>
                        </ul>
                    </li>

                    <li>
                        <a href="#">
                            <i class="ace-icon fa fa-envelope"></i>
                            Messages
                            <span class="badge badge-warning">45</span>
                        </a>
                    </li>
                </ul>-->
                <template v-for="navPlugin in navPlugins"><component :is="navPlugin"></component></template>

                <form class="navbar-form navbar-left form-search" role="search">
                    <div class="form-group">
                        <input type="text" placeholder="search">
                    </div>

                    <button type="button" class="btn btn-mini btn-info2">
                        <i class="ace-icon fa fa-search icon-only bigger-110"></i>
                    </button>
                </form>
            </nav>
        </div><!-- /.navbar-container -->
    </div>

<div class="main-container ace-save-state" id="main-container">
    <#--<script type="text/javascript">-->
        <#--try{ace.settings.loadState('main-container')}catch(e){}-->
    <#--</script>-->

    <div id="sidebar" class="sidebar      h-sidebar                navbar-collapse collapse          ace-save-state " data-sidebar="true" data-sidebar-scroll="true" data-sidebar-hover="true">
       <#-- <script type="text/javascript">
            try{ace.settings.loadState('sidebar')}catch(e){}
        </script>-->

        <div class="sidebar-shortcuts" id="sidebar-shortcuts">
            <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
                <button class="btn btn-success">
                    <i class="ace-icon fa fa-signal"></i>
                </button>

                <button class="btn btn-info">
                    <i class="ace-icon fa fa-pencil"></i>
                </button>

                <button class="btn btn-warning">
                    <i class="ace-icon fa fa-users"></i>
                </button>

                <button class="btn btn-danger">
                    <i class="ace-icon fa fa-cogs"></i>
                </button>
            </div>

            <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
                <span class="btn btn-success"></span>

                <span class="btn btn-info"></span>

                <span class="btn btn-warning"></span>

                <span class="btn btn-danger"></span>
            </div>
        </div><!-- /.sidebar-shortcuts -->

        <ul class="nav nav-list"  style="top: 0px;" >
<#--

            <template v-if="navMenuList[0]">
                <template v-for="subscreen in navMenuList[0].subscreens">
                    <li><a :href="getLinkPath(subscreen.pathWithParams)" class="dropdown-toggle"><i class="menu-icon fa " :class="subscreen.image"></i><span class="menu-text">{{subscreen.title}}</span>

                        <template v-if="subscreen.subscreens"><b class="arrow fa fa-angle-down"></b></template></a>

                        <template v-if="subscreen.subscreens">

                            <b class="arrow"></b>
                            <ul class="submenu">
                            <template v-for="subscreen1 in subscreen.subscreens">
                                <li><a href="#" class="dropdown-toggle"><i class="menu-icon fa fa-caret-right"></i>{{subscreen1.title}}<template v-if="subscreen1.subscreens"><b class="arrow fa fa-angle-down"></b></template></a><b class="arrow"></b>
                                    <template v-if="subscreen1.subscreens">

                                       <b class="arrow"></b>
                                       <ul class="submenu">
                                           <template v-for="subscreen2 in subscreen1.subscreens">
                                               <li><a :href="getLinkPath(subscreen2.pathWithParams)"><i class="menu-icon fa fa-caret-right"></i>{{subscreen2.title}}</a><b class="arrow"></b></li>
                                           </template>
                                       </ul>
                                   </template>

                                </li>
                            </template>
                            </ul>
                        </template>
                    </li>
                </template>
            </template>
-->

<#-----{{navMenuList[1].name}}===-->
            <#--<template v-if="navMenuList[0]">
                <template v-for="subscreen in navMenuList[0].subscreens">
                    <li :class="[{active:subscreen.active}, {open:subscreen.active}]" class="hover"><a :href="getLinkPath(subscreen.pathWithParams)" class="dropdown-toggle"><i class="menu-icon fa " :class="subscreen.image"></i><span class="menu-text">{{subscreen.title}}</span>

                        <template v-if="subscreen.name == navMenuList[1].name"><b class="arrow fa fa-angle-down"></b></template></a>

                        <template v-if="subscreen.name == navMenuList[1].name">

                            <b class="arrow"></b>
                            <ul class="submenu can-scroll">
                            <template v-for="subscreen1 in navMenuList[1].subscreens">
                                <li :class="{open:subscreen1.active}" class="hover"><a :href="getLinkPath(subscreen1.pathWithParams)" class="dropdown-toggle"><i class="menu-icon fa fa-caret-right"></i>{{subscreen1.title}}
                                    <template v-if="subscreen1.name==navMenuList[2].name && navMenuList[2].subscreens && navMenuList[2].subscreens.length>0"><b class="arrow fa fa-angle-down"></b></template></a><b class="arrow"></b>
                                    <template v-if="subscreen1.name==navMenuList[2].name && navMenuList[2].subscreens && navMenuList[2].subscreens.length>0">
                                       <b class="arrow"></b>
                                       <ul class="submenu can-scroll">
                                           <template v-for="subscreen2 in navMenuList[2].subscreens">
                                               <li ><a :href="getLinkPath(subscreen2.pathWithParams)"><i class="menu-icon fa fa-leaf green"></i>{{subscreen2.title}}</a><b class="arrow"></b></li>
                                           </template>
                                       </ul>
                                   </template>

                                </li>
                            </template>
                            </ul>
                        </template>
                    </li>
                </template>
            </template>
-->

    <template v-if="navMenuList[0]">
        <template v-for="subscreen in navMenuList[0].subscreens">
            <li :class="[{active:subscreen.active}, {open:subscreen.active}]" class="hover"><a :href="getLinkPath(subscreen.pathWithParams)" class="dropdown-toggle"><i class="menu-icon fa " :class="subscreen.image"></i><span class="menu-text">{{subscreen.title}}</span>

                <template v-if="subscreen.subscreens"><b class="arrow fa fa-angle-down"></b></template></a>


                    <b class="arrow"></b>
                    <ul class="submenu can-scroll">
                        <template v-for="subscreen1 in subscreen.subscreens">
                            <li :class="[{active:subscreen1.active}, {open:subscreen1.active}]" class="hover"><a :href="getLinkPath(subscreen1.pathWithParams)" class="dropdown-toggle"><i class="menu-icon fa fa-caret-right"></i>{{subscreen1.title}}
                                <template v-if="subscreen1.name==subscreen1.name && subscreen1.subscreens && subscreen1.subscreens.length>0"><b class="arrow fa fa-angle-down"></b></template></a><b class="arrow"></b>
                                <template v-if="subscreen1.name==subscreen1.name && subscreen1.subscreens && subscreen1.subscreens.length>0">
                                    <b class="arrow"></b>
                                    <ul class="submenu can-scroll">
                                        <template v-for="subscreen2 in subscreen1.subscreens">
                                            <li :class="{active:subscreen2.active}" class="hover"><a :href="getLinkPath(subscreen2.pathWithParams)"><i class="menu-icon fa fa-leaf green"></i>{{subscreen2.title}}</a><b class="arrow"></b></li>
                                        </template>
                                    </ul>
                                </template>

                            </li>
                        </template>
                    </ul>
            </li>
        </template>
    </template>


<#--
            <li class="active open">
                <a href="#" class="dropdown-toggle"><i class="menu-icon fa fa-desktop"></i><span class="menu-text">HiveMind PM </span><b class="arrow fa fa-angle-down"></b></a>

                <b class="arrow"></b>

                <ul class="submenu">


                    <li><a href="/ace/hm/dashboard"><i class="menu-icon fa fa-caret-right"></i>Dashboard</a><b class="arrow"></b></li>

                    <li><a href="/ace/hm/Search"><i class="menu-icon fa fa-caret-right"></i>Search</a><b class="arrow"></b></li>
                    <li class="active">
                        <a href="/ace/hm/Project/FindProject">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Projects
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li >
                        <a href="/ace/hm/Task/FindTask">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Tasks
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="/ace/hm/Request/FindRequest">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Requests
                        </a>

                        <b class="arrow"></b>
                    </li>


                </ul>
            </li>

            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-list"></i>
                    <span class="menu-text"> HiveMind Admin </span>

                    <b class="arrow fa fa-angle-down"></b>
                </a>

                <b class="arrow"></b>

                <ul class="submenu">
                    <li class="">
                        <a href="tables.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Simple &amp; Dynamic
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="jqgrid.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            jqGrid plugin
                        </a>

                        <b class="arrow"></b>
                    </li>
                </ul>
            </li>

            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-pencil-square-o"></i>
                    <span class="menu-text"> POPC ERP </span>

                    <b class="arrow fa fa-angle-down"></b>
                </a>

                <b class="arrow"></b>

                <ul class="submenu">
                    <li class="">
                        <a href="form-elements.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Form Elements
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="form-elements-2.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Form Elements 2
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="form-wizard.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Wizard &amp; Validation
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="wysiwyg.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Wysiwyg &amp; Markdown
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="dropzone.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Dropzone File Upload
                        </a>

                        <b class="arrow"></b>
                    </li>
                </ul>
            </li>

            <li class="">
                <a href="widgets.html">
                    <i class="menu-icon fa fa-list-alt"></i>
                    <span class="menu-text"> Example </span>
                </a>

                <b class="arrow"></b>
            </li>

            <li class="">
                <a href="calendar.html">
                    <i class="menu-icon fa fa-calendar"></i>

                    <span class="menu-text">
								My Account

								<span class="badge badge-transparent tooltip-error" title="" data-original-title="2 Important Events">
									<i class="ace-icon fa fa-exclamation-triangle red bigger-130"></i>
								</span>
							</span>
                </a>

                <b class="arrow"></b>
            </li>

            <li class="">
                <a href="gallery.html">
                    <i class="menu-icon fa fa-picture-o"></i>
                    <span class="menu-text"> System </span>
                </a>

                <b class="arrow"></b>
            </li>

            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-tag"></i>
                    <span class="menu-text">Tools </span>

                    <b class="arrow fa fa-angle-down"></b>
                </a>

                <b class="arrow"></b>

                <ul class="submenu">
                    <li class="">
                        <a href="profile.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            User Profile
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="inbox.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Inbox
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="pricing.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Pricing Tables
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="invoice.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Invoice
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="timeline.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Timeline
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="search.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Search Results
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="email.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Email Templates
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="login.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Login &amp; Register
                        </a>

                        <b class="arrow"></b>
                    </li>
                </ul>
            </li>

            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-file-o"></i>

                    <span class="menu-text">
								Other Pages

								<span class="badge badge-primary">5</span>
							</span>

                    <b class="arrow fa fa-angle-down"></b>
                </a>

                <b class="arrow"></b>

                <ul class="submenu">
                    <li class="">
                        <a href="faq.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            FAQ
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="error-404.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Error 404
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="error-500.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Error 500
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="grid.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Grid
                        </a>

                        <b class="arrow"></b>
                    </li>

                    <li class="">
                        <a href="blank.html">
                            <i class="menu-icon fa fa-caret-right"></i>
                            Blank Page
                        </a>

                        <b class="arrow"></b>
                    </li>
                </ul>
            </li>-->
        </ul> <!-- /.nav-list -->

        <#--<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
            <i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
        </div>-->
    </div>

    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <#--<div class="ace-settings-container" id="ace-settings-container">
                    <div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
                        <i class="ace-icon fa fa-cog bigger-130"></i>
                    </div>

                    <div class="ace-settings-box clearfix" id="ace-settings-box">
                        <div class="pull-left width-50">
                            <div class="ace-settings-item">
                                <div class="pull-left">
                                    <select id="skin-colorpicker" class="hide">
                                        <option data-skin="no-skin" value="#438EB9">#438EB9</option>
                                        <option data-skin="skin-1" value="#222A2D">#222A2D</option>
                                        <option data-skin="skin-2" value="#C6487E">#C6487E</option>
                                        <option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
                                    </select><div class="dropdown dropdown-colorpicker">		<a data-toggle="dropdown" class="dropdown-toggle"><span class="btn-colorpicker" style="background-color:#438EB9"></span></a><ul class="dropdown-menu dropdown-caret"><li><a class="colorpick-btn selected" style="background-color:#438EB9;" data-color="#438EB9"></a></li><li><a class="colorpick-btn" style="background-color:#222A2D;" data-color="#222A2D"></a></li><li><a class="colorpick-btn" style="background-color:#C6487E;" data-color="#C6487E"></a></li><li><a class="colorpick-btn" style="background-color:#D0D0D0;" data-color="#D0D0D0"></a></li></ul></div>
                                </div>
                                <span>&nbsp; Choose Skin</span>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2 ace-save-state" id="ace-settings-navbar" autocomplete="off">
                                <label class="lbl" for="ace-settings-navbar"> Fixed Navbar</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2 ace-save-state" id="ace-settings-sidebar" autocomplete="off">
                                <label class="lbl" for="ace-settings-sidebar"> Fixed Sidebar</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2 ace-save-state" id="ace-settings-breadcrumbs" autocomplete="off">
                                <label class="lbl" for="ace-settings-breadcrumbs"> Fixed Breadcrumbs</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" autocomplete="off">
                                <label class="lbl" for="ace-settings-rtl"> Right To Left (rtl)</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2 ace-save-state" id="ace-settings-add-container" autocomplete="off">
                                <label class="lbl" for="ace-settings-add-container">
                                    Inside
                                    <b>.container</b>
                                </label>
                            </div>
                        </div><!-- /.pull-left &ndash;&gt;

                        <div class="pull-left width-50">
                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-hover" autocomplete="off">
                                <label class="lbl" for="ace-settings-hover"> Submenu on Hover</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-compact" autocomplete="off">
                                <label class="lbl" for="ace-settings-compact"> Compact Sidebar</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-highlight" autocomplete="off">
                                <label class="lbl" for="ace-settings-highlight"> Alt. Active Item</label>
                            </div>
                        </div><!-- /.pull-left &ndash;&gt;
                    </div><!-- /.ace-settings-box &ndash;&gt;
                </div>--><!-- /.ace-settings-container -->


                <div class="row">
                    <div class="col-xs-12">
                        <!-- PAGE CONTENT BEGINS -->


                        <div class="center">
                            <subscreens-active></subscreens-active>
                        </div>

                        <!-- PAGE CONTENT ENDS -->
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div>

        </div><!-- /.main-content-inner -->
    </div><!-- /.main-content -->
        <div class="footer">
            <div class="footer-inner">
                <div class="footer-content">
						<span class="bigger-120">
							<span class="blue bolder">Moqui</span>
							ERP © 2013-2014
						</span>

                    &nbsp; &nbsp;
                    <span class="action-buttons">
							<a href="#">
								<i class="ace-icon fa fa-twitter-square light-blue bigger-150"></i>
							</a>

							<a href="#">
								<i class="ace-icon fa fa-facebook-square text-primary bigger-150"></i>
							</a>

							<a href="#">
								<i class="ace-icon fa fa-rss-square orange bigger-150"></i>
							</a>
						</span>
                </div>
            </div>
        </div>
</div><!--end main-container-->
</div><!-- /#apps-root -->

<!-- ace scripts -->
<#--<script src="/ace/assets/js/ace-elements.min.js"></script>-->
<#--<script src="/ace/assets/js/ace.min.js"></script>-->
