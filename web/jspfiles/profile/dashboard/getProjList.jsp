/*
 * Copyright (C) 2012  Krawler Information Systems Pvt Ltd
 * All rights reserved.
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page  language="java" %>
<%@ page import="com.krawler.esp.database.*" %>
<%@ page import="com.krawler.esp.handlers.AuthHandler"%>
<%@ page import="com.krawler.common.session.SessionExpiredException"%>
<jsp:useBean id="sessionbean" scope="session" class="com.krawler.esp.handlers.SessionHandler" />
<%
	if (sessionbean.validateSession(request, response)) {
		try {
			String ulogin = null;
			String upagesize = "0";
			String upageno = "0";
                        String ss = "";
			ulogin = AuthHandler.getUserid(request);
			upagesize = request.getParameter("pageSize");
			upageno = request.getParameter("pageno");
                        if(request.getParameter("ss1")==null){
                            ss = (request.getParameter("ss")!=null)?request.getParameter("ss"):"";
                        }else{
                            ss = request.getParameter("ss1");
                        }
                        
			int offset = (Integer.parseInt(upagesize) * Integer
					.parseInt(upageno));
			int pagesize1 = Integer.parseInt(upagesize);

			String splitString = dbcon.getProjectList(ulogin,
					pagesize1, offset,ss);
                        com.krawler.utils.json.base.JSONObject jbj = new com.krawler.utils.json.base.JSONObject();
                        jbj.put("valid", "true");
                        jbj.put("data", splitString);
                        out.print(jbj.toString());
		} catch (SessionExpiredException sex) {
			out.println("{\"data\": []}");
		}
	} else {
		out.println("{\"valid\": false");
	}
%>
