
<%
	/**
	 * OpenCPS is the open source Core Public Services software
	 * Copyright (C) 2016-present OpenCPS community
	 * 
	 * This program is free software: you can redistribute it and/or modify
	 * it under the terms of the GNU Affero General Public License as published by
	 * the Free Software Foundation, either version 3 of the License, or
	 * any later version.
	 * 
	 * This program is distributed in the hope that it will be useful,
	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	 * GNU Affero General Public License for more details.
	 * You should have received a copy of the GNU Affero General Public License
	 * along with this program. If not, see <http://www.gnu.org/licenses/>.
	 */
%>


<%@ include file="../init.jsp"%>

<%
	
%>


<aui:nav-bar cssClass="opencps-toolbar custom-toolbar">
	<aui:nav id="toolbarContainer"
		cssClass="nav-button-container  nav-display-style-buttons pull-left">
		<c:if test="<%=true%>">

			<portlet:renderURL var="addPaymentConfigUrl" windowState="<%=LiferayWindowState.POP_UP.toString() %>">
				<portlet:param name="mvcPath"
					value="/html/portlets/paymentmgt/paymentconfig/paymentconfig_edit.jsp" />
			</portlet:renderURL>

			<aui:button 
				icon="icon-plus"
				cssClass="action-button"
				value='<%=String.valueOf(LanguageUtil.get(pageContext,
								"add-payment-config"))%>'
				id="popup_id"
				useDialog="true"
				href="<%=addPaymentConfigUrl.toString()%>"
			 />
		</c:if>
	</aui:nav>
</aui:nav-bar>

<%!private Log _log = LogFactoryUtil
			.getLog("html.portlets.notificationmgt.backoffice.status.toolbar");%>