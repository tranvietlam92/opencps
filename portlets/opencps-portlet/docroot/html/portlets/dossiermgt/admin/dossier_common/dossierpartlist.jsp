<%
/**
 * OpenCPS is the open source Core Public Services software
 * Copyright (C) 2016-present OpenCPS community
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 fds * any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
%>
<%@page import="org.opencps.util.WebKeys"%>
<%@page import="org.opencps.util.MessageKeys"%>
<%@page import="javax.portlet.PortletConfig"%>
<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@page import="org.opencps.dossiermgt.model.DossierTemplate"%>
<%@page import="org.opencps.dossiermgt.permissions.DossierPartPermission"%>
<%@page import="com.liferay.portal.kernel.dao.search.SearchEntry"%>
<%@page import="org.opencps.dossiermgt.service.DossierPartLocalServiceUtil"%>
<%@page import="org.opencps.dossiermgt.search.DossierPartSearchTerms"%>
<%@page import="org.opencps.dossiermgt.model.DossierPart"%>
<%@page import="org.opencps.dossiermgt.search.DossierPartSearch"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="org.opencps.util.ActionKeys"%>
<%@page import="org.opencps.dossiermgt.search.DossierTemplateDisplayTerms"%>
<%@page import="org.opencps.dossiermgt.util.DossierMgtUtil"%>
<%@ include file="../../init.jsp"%>
<%
	DossierTemplate dossierTemplate = (DossierTemplate) request.getAttribute(WebKeys.DOSSIER_TEMPLATE_ENTRY);
	PortletURL iteratorURL = renderResponse.createRenderURL();
	iteratorURL.setParameter("mvcPath", templatePath + "dossier_common/dossierpartlist.jsp");
	iteratorURL.setParameter("tabs1", DossierMgtUtil.DOSSIER_PART_TOOLBAR);
	List<DossierPart> dossierParts = new ArrayList<DossierPart>();
	List<String> headerNames = new ArrayList<String>();
	
	/* headerNames.add("row-no");
	headerNames.add("part-no");
	headerNames.add("part-name");
	headerNames.add("part-type");
	headerNames.add("part-tip"); */
	
	
	
	boolean isPermission =
					DossierPartPermission.contains(
				        themeDisplay.getPermissionChecker(),
				        themeDisplay.getScopeGroupId(), ActionKeys.ADD_DOSSIER_PART);
	
	int totalCount = 0;
	long dossierTemplateId = dossierTemplate != null ? dossierTemplate.getDossierTemplateId() : 0L;
	
	try {
		totalCount = DossierPartLocalServiceUtil.CountByTempalteId(dossierTemplateId);
	} catch (Exception e) {}
	
	if (isPermission) {
		headerNames.add("action");
	}
	
	String headers = StringUtil.merge(headerNames, StringPool.COMMA);
	
 // chua sap xep theo sibling
					
%>

<div class="ocps-serviceinfo-list">

<portlet:renderURL var="editDossierPartURL">
	<portlet:param name="mvcPath" value='<%= templatePath + "edit_dossier_part.jsp" %>'/>
	<portlet:param name="backURL" value="<%=currentURL %>"/> 
	<portlet:param name="<%=DossierTemplateDisplayTerms.DOSSIERTEMPLATE_DOSSIERTEMPLATEID %>" value="<%=String.valueOf(dossierTemplateId) %>"/>
</portlet:renderURL>

<liferay-ui:error
	key="<%= MessageKeys.DOSSIER_PART_DELETE_ERROR %>"
	message="<%= MessageKeys.DOSSIER_PART_DELETE_ERROR %>"
 />

<c:if test="<%=DossierPartPermission.contains(permissionChecker, scopeGroupId, ActionKeys.ADD_DOSSIER_PART) %>">
	<%-- <div id="<portlet:namespace/>toolbarResponse"></div> --%>
	<aui:button href="<%= editDossierPartURL.toString() %>" value="add-dossier-part"/>
</c:if>

<liferay-ui:search-container searchContainer="<%= new DossierPartSearch(renderRequest, totalCount, iteratorURL) %>" 
	headerNames="<%= headers %>">
	<liferay-ui:search-container-results>
		<%
			
			dossierParts = DossierPartLocalServiceUtil.getDossierParts(
					dossierTemplateId, searchContainer.getStart(), searchContainer.getEnd());
									
			
			
			total = totalCount;
			results = dossierParts;
			pageContext.setAttribute("results", results);
			pageContext.setAttribute("total", total);
		%>
	</liferay-ui:search-container-results>
	
	<liferay-ui:search-container-row 
		className="org.opencps.dossiermgt.model.DossierPart" 
		modelVar="dossierPart" 
		keyProperty="dossierpartId"
	>
		<%
			String partTypeName = LanguageUtil.get(portletConfig ,themeDisplay.getLocale(), DossierMgtUtil.getNameOfPartType(dossierPart.getPartType(), themeDisplay.getLocale()));
		
			String rowNo =  LanguageUtil.get(portletConfig, themeDisplay.getLocale(), "row-no");
			String partNo =  LanguageUtil.get(portletConfig, themeDisplay.getLocale(), "part-no");
			String partName =  LanguageUtil.get(portletConfig, themeDisplay.getLocale(), "part-name");
			String partType =  LanguageUtil.get(portletConfig, themeDisplay.getLocale(), "part-type");
			String parTip =  LanguageUtil.get(portletConfig, themeDisplay.getLocale(), "part-tip");
			
			
			String s = "<div class=\"ocps-searh-bound-data\"><p class=\"ocps-searh-bound-data-chirld-p\"><span class=\"ocps-searh-bound-data-chirld-span\">" + partNo + "</span>"+ dossierPart.getPartNo() +"</p>";
			s= s + "<p class=\"ocps-searh-bound-data-chirld-p\"><span class=\"ocps-searh-bound-data-chirld-span\">"+ partName +"</span><a class=\"ocps-searh-bound-data-chirld-label\" href=\"#\"> "+ dossierPart.getPartName() + "</a></p></div>";
			
			String s1 = "<div class=\"ocps-searh-bound-data\"><p class=\"ocps-searh-bound-data-chirld-p\"><span class=\"ocps-searh-bound-data-chirld-span\">" + partType + "</span>"+ partTypeName +"</p>";
			s1= s1 + "<p class=\"ocps-searh-bound-data-chirld-p\"><span class=\"ocps-searh-bound-data-chirld-span\">"+ parTip +"</span><a class=\"ocps-searh-bound-data-chirld-label\" href=\"#\"> "+ dossierPart.getPartTip() + "</a></p></div>";

			row.addText(String.valueOf((int)dossierPart.getSibling()));
			row.addText(s);
			row.addText(s1);
			
			/* row.addText(partNo + " :: " +dossierPart.getPartNo());
			row.addText(partName + " :::: " + dossierPart.getPartName());
			row.addText(partType + " ::::: " + partTypeName);
			row.addText(parTip + " :::: " + dossierPart.getPartTip()); */
			
			if(isPermission) {
				row.addJSP("center", SearchEntry.DEFAULT_VALIGN, templatePath + "dossier_part_actions.jsp", config.getServletContext(), request, response);
			}
		%>
		
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator paginate="<%=false %>"/>
</liferay-ui:search-container>

</div>