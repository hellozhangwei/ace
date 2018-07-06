<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="UTF-8">
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />    <#if html_keywords?has_content><meta name="keywords" content="${html_keywords}"></#if>
    <#if html_description?has_content><meta name="description" content="${html_description}"></#if>
    <#assign parentMenuName = (sri.screenUrlInfo.parentScreen.getDefaultMenuName())!"">
    <#assign defaultMenuName = sri.screenUrlInfo.targetScreen.getDefaultMenuName()>
    <title><#if html_title?has_content>${html_title}<#else><#if parentMenuName?has_content>${ec.resource.expand(parentMenuName, "")} - </#if><#if defaultMenuName?has_content>${ec.resource.expand(defaultMenuName, "")}</#if></#if></title>
    <link rel="apple-touch-icon" href="/MoquiLogo100.png"/>
<#-- Style Sheets -->
<#list sri.getThemeValues("STRT_STYLESHEET") as styleSheetLocation>
    <link rel="stylesheet" href="${sri.buildUrl(styleSheetLocation).url}" type="text/css">
</#list>
<#list html_stylesheets?if_exists as styleSheetLocation>
    <link rel="stylesheet" href="${sri.buildUrl(styleSheetLocation).url}" type="text/css">
</#list>
<#-- JavaScript -->
<#list html_scripts?if_exists as scriptLocation>
    <script src="${sri.buildUrl(scriptLocation).url}" type="text/javascript"></script>
</#list>
<#list sri.getThemeValues("STRT_SCRIPT") as scriptLocation>
    <script src="${sri.buildUrl(scriptLocation).url}" type="text/javascript"></script>
</#list>
<#-- Icon -->
<#list sri.getThemeValues("STRT_SHORTCUT_ICON") as iconLocation>
    <link rel="shortcut icon" href="${sri.buildUrl(iconLocation).url}">
</#list>
    <style>@keyframes nodeInserted{from{outline-color:#fff}to{outline-color:#000}}@-moz-keyframes nodeInserted{from{outline-color:#fff}to{outline-color:#000}}@-webkit-keyframes nodeInserted{from{outline-color:#fff}to{outline-color:#000}}@-ms-keyframes nodeInserted{from{outline-color:#fff}to{outline-color:#000}}@-o-keyframes nodeInserted{from{outline-color:#fff}to{outline-color:#000}}.ace-save-state{animation-duration:10ms;-o-animation-duration:10ms;-ms-animation-duration:10ms;-moz-animation-duration:10ms;-webkit-animation-duration:10ms;animation-delay:0s;-o-animation-delay:0s;-ms-animation-delay:0s;-moz-animation-delay:0s;-webkit-animation-delay:0s;animation-name:nodeInserted;-o-animation-name:nodeInserted;-ms-animation-name:nodeInserted;-moz-animation-name:nodeInserted;-webkit-animation-name:nodeInserted}</style>
    <style type="text/css">.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style>
</head>
<#assign bodyClassList = sri.getThemeValues("STRT_BODY_CLASS")>
<#assign instancePurpose = Static["java.lang.System"].getProperty("instance_purpose")!"production">
<body class="${instancePurpose} ${(ec.user.getPreference("OUTER_STYLE")!(bodyClassList?first))!"bg-light"} <#if sri.screenUrlInfo.targetScreen.screenName=='Login'>login-layout<#else>${(sri.screenUrlInfo.targetScreen.screenName)!""}</#if> <#if hideNav! == "true"> hide-nav</#if>"><!-- try "bg-dark" or "bg-light" -->
