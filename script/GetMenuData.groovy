import groovy.transform.Field
import org.moqui.impl.screen.ScreenUrlInfo
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import  org.moqui.util.StringUtilities

import org.moqui.impl.screen.ScreenDefinition
import org.moqui.impl.screen.ScreenDefinition.SubscreensItem
import org.moqui.impl.context.ContextJavaUtil

@Field Logger logger = LoggerFactory.getLogger("GetMenuData")

//List menuDataList = getMenuData1(sri.screenUrlInfo.extraPathNameList)
//if (menuDataList != null) ec.web.sendJsonResponse(menuDataList)

List menuDataList = sri.getMenuData(sri.screenUrlInfo.extraPathNameList)

ScreenDefinition currentScreenDef = sri.sfi.getScreenDefinition("component://webroot/screen/webroot/apps.xml")
def currentScreenPath = "/apps"
def appsMenu = [:]

appsMenu.name = currentScreenDef.getDefaultMenuName()
appsMenu.path = currentScreenPath
appsMenu.pathWithParams = currentScreenPath
appsMenu.title = currentScreenDef.getDefaultMenuName()
appsMenu.renderModes = currentScreenDef.renderModes


/*
logger.info("================sri.screenUrlInfo.extraPathNameList========${sri.screenUrlInfo.extraPathNameList}=")
def aa = [
    "name": "AppList",
    "title": "App List",
    "path": "/apps/AppList",
    "pathWithParams": "/apps/AppList",
    "image": null,
    "extraPathList": [],
    "screenDocList": [],
    "renderModes": [
            "all"
    ]
]

def pathNameList = sri.screenUrlInfo.extraPathNameList

if(pathNameList.size() >1) {
    for (int i = 1; i < pathNameList.size(); i++) {
        logger.info("========${pathNameList[i]}==========")
    }
}
*/



getMenuTreeData(currentScreenDef, currentScreenPath, appsMenu)
//ec.web.sendJsonResponse([appsMenu, aa])

logger.info("====currentMenu========${ContextJavaUtil.jacksonMapper.writeValueAsString(appsMenu)}============")

menuDataList[0].subscreens = appsMenu.subscreens
if (menuDataList != null) ec.web.sendJsonResponse(menuDataList)


def getMenuTreeData(ScreenDefinition parentScreenDef, parentScreenPath, appsMenu) {

    List<SubscreensItem> subscreensItems = parentScreenDef.getSubscreensItemsSorted()

    def subscreens = []

    subscreensItems.each {currentSubscreensItem->
        ScreenDefinition currentScreenDef = sri.sfi.getScreenDefinition(currentSubscreensItem.location)
        String currentScreenPath = "${parentScreenPath}/${currentSubscreensItem.name}"
        ScreenUrlInfo.UrlInstance currentUrlInfo = sri.buildUrl(currentScreenPath)
        ScreenUrlInfo sui = currentUrlInfo.sui
        if(currentScreenDef && currentSubscreensItem.getMenuInclude() && currentUrlInfo?.isPermitted() && !currentScreenDef.hasRequired) {

            String pathWithParams = "/" + sui.preTransitionPathNameList.join("/")
            String parmString = currentUrlInfo.getParameterString()
            if (!parmString.isEmpty()) pathWithParams += ('?' + parmString)

            String image = sui.menuImage
            String imageType = sui.menuImageType
            if (image != null && image.length() > 0 && (imageType == null || imageType.length() == 0 || "url-screen".equals(imageType)))
                image = sri.buildUrl(image).path


            def itemMap = [name:sui.fullPathNameList.last(), title:ec.resource.expand(currentSubscreensItem.menuTitle, "")
                           ,path: currentScreenPath,pathWithParams:pathWithParams,image:image,renderModes:sui.targetScreen.renderModes]

            if ("icon".equals(imageType)) itemMap.imageType = "icon"
            //if (active) itemMap.active = true
            if (currentUrlInfo.disableLink) itemMap.disableLink = true

            subscreens.add(itemMap)
            getMenuTreeData(currentScreenDef, currentScreenPath, itemMap)
        }

    }

    if (subscreens) {
        appsMenu.subscreens = subscreens
    }

}
/*

List<Map> getMenuData1(ArrayList<String> pathNameList) {

    ScreenDefinition rootScreenDef = sri.getRootScreenDef()

    if (!ec.user.userId) { ec.web.sendError(401, "Authentication required", null); return null }
    ScreenUrlInfo fullUrlInfo = ScreenUrlInfo.getScreenUrlInfo(sri, rootScreenDef, pathNameList, null, 0)
    if (!fullUrlInfo.targetExists) { ec.web.sendError(404, "Screen not found for path ${pathNameList}", null); return null }
    ScreenUrlInfo.UrlInstance fullUrlInstance = fullUrlInfo.getInstance(sri, null)
    if (!fullUrlInstance.isPermitted()) { ec.web.sendError(403, "View not permitted for path ${pathNameList}", null); return null }

    ArrayList<String> fullPathList = fullUrlInfo.fullPathNameList
    int fullPathSize = fullPathList.size()
    ArrayList<String> extraPathList = fullUrlInfo.extraPathNameList
    int extraPathSize = extraPathList != null ? extraPathList.size() : 0
    if (extraPathSize > 0) {
        fullPathSize -= extraPathSize
        fullPathList = new ArrayList<>(fullPathList.subList(0, fullPathSize))
    }

    StringBuilder currentPath = new StringBuilder()
    List<Map> menuDataList = new LinkedList<>()
    ScreenDefinition curScreen = rootScreenDef

    // to support menu titles with values set in pre-actions: run pre-actions for all screens in path except first 2 (generally webroot, apps)
    ec.artifactExecutionFacade.setAnonymousAuthorizedView()
    ec.userFacade.loginAnonymousIfNoUser()
    ArrayList<ScreenDefinition> preActionSds = new ArrayList<>(fullUrlInfo.screenPathDefList.subList(2, fullUrlInfo.screenPathDefList.size()))
    int preActionSdSize = preActionSds.size()
    for (int i = 0; i < preActionSdSize; i++) {
        ScreenDefinition sd = (ScreenDefinition) preActionSds.get(i)
        if (sd.preActions != null) {
            try { sd.preActions.run(ec) }
            catch (Throwable t) { logger.warn("Error running pre-actions in ${sd.getLocation()} while getting menu data: " + t.toString()) }
        }
    }

    for (int i = 0; i < (fullPathSize - 1); i++) {
        String pathItem = (String) fullPathList.get(i)
        String nextItem = (String) fullPathList.get(i+1)
        currentPath.append('/').append(StringUtilities.urlEncodeIfNeeded(pathItem))

        SubscreensItem curSsi = curScreen.getSubscreensItem(pathItem)
        // already checked for exists above, path may have extra path elements beyond the screen so allow it
        if (curSsi == null) break
        curScreen = ec.screenFacade.getScreenDefinition(curSsi.location)

        List<Map> subscreensList = new LinkedList<>()
        ArrayList<SubscreensItem> menuItems = curScreen.getMenuSubscreensItems()
        int menuItemsSize = menuItems.size()
        for (int j = 0; j < menuItemsSize; j++) {
            SubscreensItem subscreensItem = (SubscreensItem) menuItems.get(j)
            String screenPath = new StringBuilder(currentPath).append('/').append(StringUtilities.urlEncodeIfNeeded(subscreensItem.name)).toString()
            ScreenUrlInfo.UrlInstance screenUrlInstance = sri.buildUrl(screenPath)
            ScreenUrlInfo sui = screenUrlInstance.sui
            if (!screenUrlInstance.isPermitted()) continue
            // build this subscreen's pathWithParams
            String pathWithParams = "/" + sui.preTransitionPathNameList.join("/")
            Map<String, String> parmMap = screenUrlInstance.getParameterMap()
            // check for missing required parameters
            boolean parmMissing = false
            for (ScreenDefinition.ParameterItem pi in sui.pathParameterItems.values()) {
                if (!pi.required) continue
                String parmValue = parmMap.get(pi.name)
                if (parmValue == null || parmValue.isEmpty()) { parmMissing = true; break }
            }
            // if there is a parameter missing skip the subscreen
            if (parmMissing) continue
            String parmString = screenUrlInstance.getParameterString()
            if (!parmString.isEmpty()) pathWithParams += ('?' + parmString)

            String image = sui.menuImage
            String imageType = sui.menuImageType
            if (image != null && image.length() > 0 && (imageType == null || imageType.length() == 0 || "url-screen".equals(imageType)))
                image = sri.buildUrl(image).path

            boolean active = (nextItem == subscreensItem.name)
            Map itemMap = [name:subscreensItem.name, title:ec.resource.expand(subscreensItem.menuTitle, ""),
                           path:screenPath, pathWithParams:pathWithParams, image:image]
            if ("icon".equals(imageType)) itemMap.imageType = "icon"
            if (active) itemMap.active = true
            if (screenUrlInstance.disableLink) itemMap.disableLink = true
            //subscreensList.add(itemMap)
            // not needed: screenStatic:sui.targetScreen.isServerStatic(renderMode)
        }

        String curScreenPath = currentPath.toString()
        ScreenUrlInfo.UrlInstance curUrlInstance = sri.buildUrl(curScreenPath)
        String curPathWithParams = curScreenPath
        String curParmString = curUrlInstance.getParameterString()
        if (!curParmString.isEmpty()) curPathWithParams = curPathWithParams + '?' + curParmString
        menuDataList.add([name:pathItem, title:curScreen.getDefaultMenuName(), subscreens:subscreensList, path:curScreenPath,
                          pathWithParams:curPathWithParams, hasTabMenu:curScreen.hasTabMenu(), renderModes:curScreen.renderModes])//this current menu
        // not needed: screenStatic:curScreen.isServerStatic(renderMode)
    }

    String lastPathItem = (String) fullPathList.get(fullPathSize - 1)
    fullUrlInstance.addParameters(ec.web.getRequestParameters())
    currentPath.append('/').append(StringUtilities.urlEncodeIfNeeded(lastPathItem))
    String lastPath = currentPath.toString()
    String paramString = fullUrlInstance.getParameterString()
    if (paramString.length() > 0) currentPath.append('?').append(paramString)

    String lastImage = fullUrlInfo.menuImage
    String lastImageType = fullUrlInfo.menuImageType
    if (lastImage != null && lastImage.length() > 0 && (lastImageType == null || lastImageType.length() == 0 || "url-screen".equals(lastImageType)))
        lastImage = sri.buildUrl(lastImage).url
    String lastTitle = fullUrlInfo.targetScreen.getDefaultMenuName()
    if (lastTitle.contains('${')) lastTitle = ec.resourceFacade.expand(lastTitle, "")
    List<Map<String, Object>> screenDocList = fullUrlInfo.targetScreen.getScreenDocumentInfoList()

    if (extraPathList != null) {
        int extraPathListSize = extraPathList.size()
        for (int i = 0; i < extraPathListSize; i++) extraPathList.set(i, StringUtilities.urlEncodeIfNeeded(extraPathList.get(i)))
    }
    Map lastMap = [name:lastPathItem, title:lastTitle, path:lastPath, pathWithParams:currentPath.toString(), image:lastImage,
                   extraPathList:extraPathList, screenDocList:screenDocList, renderModes:fullUrlInfo.targetScreen.renderModes]
    if ("icon".equals(lastImageType)) lastMap.imageType = "icon"
    menuDataList.add(lastMap)
    // not needed: screenStatic:fullUrlInfo.targetScreen.isServerStatic(renderMode)

    // for (Map info in menuDataList) logger.warn("menu data item: ${info}")
    return menuDataList
}

*/

/*

@Field ScreenDefinition rootScreenDef = sri.getRootScreenDef()
logger.info("=============rootScreenDef.getScreenName()====${rootScreenDef.getScreenName()}")

List<Map> getMenuData2(ArrayList<String> pathNameList) {

    ScreenDefinition rootScreenDef = sri.getRootScreenDef()

    if (!ec.user.userId) { ec.web.sendError(401, "Authentication required", null); return null }
    ScreenUrlInfo fullUrlInfo = ScreenUrlInfo.getScreenUrlInfo(sri, rootScreenDef, pathNameList, null, 0)
    if (!fullUrlInfo.targetExists) { ec.web.sendError(404, "Screen not found for path ${pathNameList}", null); return null }
    ScreenUrlInfo.UrlInstance fullUrlInstance = fullUrlInfo.getInstance(sri, null)
    if (!fullUrlInstance.isPermitted()) { ec.web.sendError(403, "View not permitted for path ${pathNameList}", null); return null }

    ArrayList<String> fullPathList = fullUrlInfo.fullPathNameList
    int fullPathSize = fullPathList.size()
    ArrayList<String> extraPathList = fullUrlInfo.extraPathNameList
    int extraPathSize = extraPathList != null ? extraPathList.size() : 0
    if (extraPathSize > 0) {
        fullPathSize -= extraPathSize
        fullPathList = new ArrayList<>(fullPathList.subList(0, fullPathSize))
    }

    StringBuilder currentPath = new StringBuilder()
    List<Map> menuDataList = new LinkedList<>()
    ScreenDefinition curScreen = rootScreenDef

    // to support menu titles with values set in pre-actions: run pre-actions for all screens in path except first 2 (generally webroot, apps)
    ec.artifactExecutionFacade.setAnonymousAuthorizedView()
    ec.userFacade.loginAnonymousIfNoUser()
    ArrayList<ScreenDefinition> preActionSds = new ArrayList<>(fullUrlInfo.screenPathDefList.subList(2, fullUrlInfo.screenPathDefList.size()))
    int preActionSdSize = preActionSds.size()
    for (int i = 0; i < preActionSdSize; i++) {
        ScreenDefinition sd = (ScreenDefinition) preActionSds.get(i)
        if (sd.preActions != null) {
            try { sd.preActions.run(ec) }
            catch (Throwable t) { logger.warn("Error running pre-actions in ${sd.getLocation()} while getting menu data: " + t.toString()) }
        }
    }

    for (int i = 0; i < (fullPathSize - 1); i++) {
        String pathItem = (String) fullPathList.get(i)
        String nextItem = (String) fullPathList.get(i+1)
        currentPath.append('/').append(StringUtilities.urlEncodeIfNeeded(pathItem))

        SubscreensItem curSsi = curScreen.getSubscreensItem(pathItem)
        // already checked for exists above, path may have extra path elements beyond the screen so allow it
        if (curSsi == null) break
        curScreen = ec.screenFacade.getScreenDefinition(curSsi.location)

        List<Map> subscreensList = new LinkedList<>()
        ArrayList<SubscreensItem> menuItems = curScreen.getMenuSubscreensItems()
        int menuItemsSize = menuItems.size()
        for (int j = 0; j < menuItemsSize; j++) {
            SubscreensItem subscreensItem = (SubscreensItem) menuItems.get(j)
            String screenPath = new StringBuilder(currentPath).append('/').append(StringUtilities.urlEncodeIfNeeded(subscreensItem.name)).toString()
            ScreenUrlInfo.UrlInstance screenUrlInstance = sri.buildUrl(screenPath)
            ScreenUrlInfo sui = screenUrlInstance.sui
            if (!screenUrlInstance.isPermitted()) continue
            // build this subscreen's pathWithParams
            String pathWithParams = "/" + sui.preTransitionPathNameList.join("/")
            Map<String, String> parmMap = screenUrlInstance.getParameterMap()
            // check for missing required parameters
            boolean parmMissing = false
            for (ScreenDefinition.ParameterItem pi in sui.pathParameterItems.values()) {
                if (!pi.required) continue
                String parmValue = parmMap.get(pi.name)
                if (parmValue == null || parmValue.isEmpty()) { parmMissing = true; break }
            }
            // if there is a parameter missing skip the subscreen
            if (parmMissing) continue
            String parmString = screenUrlInstance.getParameterString()
            if (!parmString.isEmpty()) pathWithParams += ('?' + parmString)

            String image = sui.menuImage
            String imageType = sui.menuImageType
            if (image != null && image.length() > 0 && (imageType == null || imageType.length() == 0 || "url-screen".equals(imageType)))
                image = sri.buildUrl(image).path

            boolean active = (nextItem == subscreensItem.name)
            Map itemMap = [name:subscreensItem.name, title:ec.resource.expand(subscreensItem.menuTitle, ""),
                           path:screenPath, pathWithParams:pathWithParams, image:image]
            if ("icon".equals(imageType)) itemMap.imageType = "icon"
            if (active) itemMap.active = true
            if (screenUrlInstance.disableLink) itemMap.disableLink = true
            subscreensList.add(itemMap)
            // not needed: screenStatic:sui.targetScreen.isServerStatic(renderMode)
        }

        String curScreenPath = currentPath.toString()
        ScreenUrlInfo.UrlInstance curUrlInstance = sri.buildUrl(curScreenPath)
        String curPathWithParams = curScreenPath
        String curParmString = curUrlInstance.getParameterString()
        if (!curParmString.isEmpty()) curPathWithParams = curPathWithParams + '?' + curParmString
        menuDataList.add([name:pathItem, title:curScreen.getDefaultMenuName(), subscreens:subscreensList, path:curScreenPath,
                          pathWithParams:curPathWithParams, hasTabMenu:curScreen.hasTabMenu(), renderModes:curScreen.renderModes])//this current menu
        // not needed: screenStatic:curScreen.isServerStatic(renderMode)
    }

    String lastPathItem = (String) fullPathList.get(fullPathSize - 1)
    fullUrlInstance.addParameters(ec.web.getRequestParameters())
    currentPath.append('/').append(StringUtilities.urlEncodeIfNeeded(lastPathItem))
    String lastPath = currentPath.toString()
    String paramString = fullUrlInstance.getParameterString()
    if (paramString.length() > 0) currentPath.append('?').append(paramString)

    String lastImage = fullUrlInfo.menuImage
    String lastImageType = fullUrlInfo.menuImageType
    if (lastImage != null && lastImage.length() > 0 && (lastImageType == null || lastImageType.length() == 0 || "url-screen".equals(lastImageType)))
        lastImage = sri.buildUrl(lastImage).url
    String lastTitle = fullUrlInfo.targetScreen.getDefaultMenuName()
    if (lastTitle.contains('${')) lastTitle = ec.resourceFacade.expand(lastTitle, "")
    List<Map<String, Object>> screenDocList = fullUrlInfo.targetScreen.getScreenDocumentInfoList()

    if (extraPathList != null) {
        int extraPathListSize = extraPathList.size()
        for (int i = 0; i < extraPathListSize; i++) extraPathList.set(i, StringUtilities.urlEncodeIfNeeded(extraPathList.get(i)))
    }
    Map lastMap = [name:lastPathItem, title:lastTitle, path:lastPath, pathWithParams:currentPath.toString(), image:lastImage,
                   extraPathList:extraPathList, screenDocList:screenDocList, renderModes:fullUrlInfo.targetScreen.renderModes]
    if ("icon".equals(lastImageType)) lastMap.imageType = "icon"
    menuDataList.add(lastMap)
    // not needed: screenStatic:fullUrlInfo.targetScreen.isServerStatic(renderMode)

    // for (Map info in menuDataList) logger.warn("menu data item: ${info}")
    return menuDataList
}
*/
