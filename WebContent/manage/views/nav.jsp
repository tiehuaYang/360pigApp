<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!-- Search box -->
<div class="form-search">
	<form id="site-search" action="#na">
		<input type="search" class="form-control" placeholder="Enter your query...">
		<button type="submit" class="fa fa-search"></button>
	</form>
</div>


<!-- Site nav (vertical) -->

<nav class="site-nav clearfix" role="navigation" collapse-nav-accordion highlight-active>
	<div class="nav-title panel-heading"><i>我的导航&nbsp;&nbsp;</i></div>
	<ul class="list-unstyled nav-list">
		<li>
			<a href="#/dashboard">
				<i class="fa fa-desktop icon"></i>
				<span class="text">Dashboard</span>
			</a>
		</li>
		<li>
			<a href="javascript:;">
				<i class="fa fa-group icon"></i>
				<span class="text">供应商管理</span>
				<i class="arrow fa fa-angle-right right"></i>
			</a>
			<ul class="inner-drop list-unstyled">
				<li><a href="${contextPath}/manage/showSupplier">查询</a></li>
			</ul>
		</li>
		<li>
			<a href="#/email/inbox">
				<i class="fa fa-paper-plane icon"></i>
				<span class="text">Email</span>
			</a>
		</li>
		<li>
			<a href="#/widgets">
				<i class="fa fa-star-o icon"></i>
				<span class="text">Widgets</span>
				<span class="badge badge-xs badge-primary right">new</span>
			</a>
		</li>
	</ul>
	<div class="nav-title panel-heading"><i>Components</i></div>
	<ul class="list-unstyled nav-list">
		<li>
			<a href="javascript:;">
				<i class="fa fa-paint-brush icon"></i>
				<span class="text">UI Elements</span>
				<i class="arrow fa fa-angle-right right"></i>
				<span class="badge badge-xs badge-info">8</span>
			</a>
			<ul class="inner-drop list-unstyled">
				<li><a href="#/ui/buttons">Buttons</a></li>
				<li><a href="#/ui/typography">Typography</a></li>
				<li><a href="#/ui/icons">Font Icons</a></li>
				<li><a href="#/ui/toasts">Toasts and Alerts</a></li>
				<li><a href="#/ui/tabs">Tabs &amp; Accordion</a></li>
				<li><a href="#/ui/grids">Grids</a></li>
				<li><a href="#/ui/panels">Panels</a></li>
				<li><a href="#/ui/misc">Misc</a></li>
			</ul>
		</li>
		<li>
			<a href="javascript:;">
				<i class="fa fa-building icon"></i>
				<span class="text">Forms</span>
				<i class="arrow fa fa-angle-right right"></i>
			</a>
			<ul class="inner-drop list-unstyled">
				<li><a href="#/forms/form-elems">Form Elements</a></li>
				<li><a href="#/forms/form-validation">Form Validation</a></li>
				<li><a href="#/forms/form-wizard">Form Wizard</a></li>
			</ul>
		</li>
		<li>
			<a href="javascript:;">
				<i class="fa fa-table icon"></i>
				<span class="text">Tables</span>
				<i class="arrow fa fa-angle-right right"></i>
			</a>
			<ul class="inner-drop list-unstyled">
				<li><a href="#/tables/static-table">Static Table</a></li>
				<li><a href="#/tables/data-table">Data Table</a></li>
			</ul>
		</li>
		<li>
			<a href="#/charts/charts">
				<i class="fa fa-pie-chart icon"></i>
				<span class="text">Charts</span>

			</a>
		</li>
		<li>
			<a href="javascript:;">
				<i class="fa fa-file-text icon"></i>
				<span class="text">Pages</span>
				<i class="arrow fa fa-angle-right right"></i>
				<span class="badge badge-xs right circle badge-primary">5</span>
			</a>
			<ul class="inner-drop list-unstyled">
				<li><a href="#/pages/register">Register</a></li>
				<li><a href="#/pages/login">Login</a></li>
				<li><a href="#/pages/forget-pass">Forget Pass</a></li>
				<li><a href="#/pages/lock-screen">Lock Screen</a></li>
				<li><a href="#/pages/404">404</a></li>
			</ul>
		</li>
		<li>
			<a href="javascript:;">
				<i class="fa fa-leaf icon"></i>
				<span class="text">Extras</span>
				<i class="arrow fa fa-angle-right right"></i>
				<span class="badge badge-xs right badge-success">new</span>
			</a>
			<ul class="inner-drop list-unstyled">
				<li><a href="#/pages/invoice">Invoice</a></li>
				<li><a href="#/pages/profile">Profile</a></li>
				<li><a href="#/pages/timeline">Timeline</a></li>
			</ul>
		</li>
	</ul>
</nav>


<!-- theme settings -->
<div class="theme-settings clearfix">
	<div class="panel-heading"><i>Themes</i></div>
	<ul class="list-unstyled clearfix">
		<li ng-class="{active: theme-zero}" ng-model="themeModel" btn-radio="'theme-zero'" ng-change="onThemeChange(themeModel)">
			<a href="javascript:;">
				<span class="side-top"></span>
				<span class="header"></span>
				<span class="side-rest"></span>
			</a>
		</li>

		<li ng-class="{active: theme-one}" ng-model="themeModel" btn-radio="'theme-one'" ng-change="onThemeChange(themeModel)">
			<a href="javascript:;">
				<span class="side-top"></span>
				<span class="header"></span>
				<span class="side-rest"></span>
			</a>
		</li>

		<li ng-class="{active: theme-two}" ng-model="themeModel" btn-radio="'theme-two'" ng-change="onThemeChange(themeModel)">
			<a href="javascript:;">
				<span class="side-top"></span>
				<span class="header"></span>
				<span class="side-rest"></span>
			</a>
		</li>

		<li ng-class="{active: theme-three}" ng-model="themeModel" btn-radio="'theme-three'" ng-change="onThemeChange(themeModel)">
			<a href="javascript:;">
				<span class="side-top"></span>
				<span class="header"></span>
				<span class="side-rest"></span>
			</a>
		</li>

		<li ng-class="{active: theme-four}" ng-model="themeModel" btn-radio="'theme-four'" ng-change="onThemeChange(themeModel)">
			<a href="javascript:;">
				<span class="side-top"></span>
				<span class="header"></span>
				<span class="side-rest"></span>
			</a>
		</li>
	</ul>
</div>
<!-- #end theme settings -->