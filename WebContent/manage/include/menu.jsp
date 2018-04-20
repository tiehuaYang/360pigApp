<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="com.pig.common.CommonConstants" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<c:set var="enterpriseLevel" value="<%= CommonConstants.USER.USER_LEVEL_ENTERPRISE %>"></c:set>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

                <nav id="sidebar" role="navigation" class="navbar-default navbar-static-side">
                
                    <div style="height: auto;min-height: 768px;">
                        <div class="sidebar-collapse menu-scroll">
                            <ul id="side-menu" class="nav">
                                <li class="user-panel">
                                    <div class="thumb">
                                        <c:choose>
                                            <c:when test="${!empty sessionScope.USERVO.pictureVO.uploadUrl}">
                                                <img src="${QUPLOADIMG}${sessionScope.USERVO.pictureVO.uploadUrl}" alt="" class="img-circle" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${contextPath}/images/default_user.jpg" alt="" class="img-circle" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="info">
                                        <p>${sessionScope.USERVO.userName}</p>
                                        <ul class="list-inline list-unstyled">
                                            <li><a href="myProfile.jsp" data-hover="tooltip" title="个人资料"><i class="fa fa-user"></i></a>
                                            </li>
                                            <li><a href="${contextPath}/manage/showPendingTaskList" data-hover="tooltip" title="待办任务"><i class="fa fa-tasks"></i></a>
                                            </li>
                                            <li><a href="${contextPath}/logout" data-hover="tooltip" title="注销"><i class="fa fa-sign-out"></i></a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </li>

                                <li id="companyMenu">
                                    <a href="javascript:void(0);">
                                        <i class="fa fa-slack fa-fw" style="color:rgba(0,0,0,.5);"><div class="icon-bg bg-pink"></div></i>
                                        <span class="menu-title">企业管理</span><span class="fa arrow"></span>
                                    </a>
                                    <ul id="companyUL" class="nav nav-second-level">
                                        <li>
                                            <a data-default="1">
                                                <i class="fa fa-file-text-o"></i><span class="submenu-title:disabled" style="margin-left:30%;color:#999996;">企业管理</span>
                                            </a>
                                        </li>
                                        <li id="peopleMenu"><a href="${contextPath}/manage/showStuff"><i class="fa fa-user"></i><span class="submenu-title" style="margin-left:30%;">员工帐号管理</span></a>
                                        </li>
                                    </ul>

                                </li>

                                <li id="pigCategoryManageMenu">
                                    <a href="javascript:void(0);" class="hoverChangeColor">
                                        <i class="fa fa-tags fa-fw hoverChangeColor" style="color:rgba(0,0,0,.5);"><div class="icon-bg bg-pink"></div></i>
                                        <span class="menu-title hoverChangeColor">品类管理</span><span class="fa arrow"></span>
                                    </a>
                                    <ul id="pigCategoryUL" class="nav nav-second-level">
                                        <li>
                                            <a data-default="1">
                                                <i class="fa fa-file-text-o"></i><span class="submenu-title:disabled" style="margin-left:40%;color:#999996;">品类管理</span>
                                            </a>
                                        </li>
                                        <li id="pigCategoryMenu">
                                            <a href="${contextPath}/manage/queryPigCategory">
                                                <i class="fa fa-file-text-o"></i><span class="submenu-title" style="margin-left:40%;">品类</span>
                                            </a>
                                        </li>
                                        <li id="pigCategoryStrainMenu">
                                            <a href="${contextPath}/manage/queryPigStrain">
                                                <i class="fa fa-reply"></i><span class="submenu-title" style="margin-left:40%;">品系</span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>

                            </ul>
                        </div>
                    </div>
                </nav>
