/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.78
 * Generated at: 2024-03-11 08:22:20 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.board;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class boardJoin_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(7);
    _jspx_dependants.put("jar:file:/C:/Users/82104/Desktop/coding/workExperience/spring/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/springBoard/WEB-INF/lib/jstl-1.2.jar!/META-INF/fn.tld", Long.valueOf(1153352682000L));
    _jspx_dependants.put("/WEB-INF/lib/jstl-1.2.jar", Long.valueOf(1709601169261L));
    _jspx_dependants.put("/WEB-INF/lib/spring-webmvc-3.1.1.RELEASE.jar", Long.valueOf(1709601169466L));
    _jspx_dependants.put("jar:file:/C:/Users/82104/Desktop/coding/workExperience/spring/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/springBoard/WEB-INF/lib/jstl-1.2.jar!/META-INF/fmt.tld", Long.valueOf(1153352682000L));
    _jspx_dependants.put("jar:file:/C:/Users/82104/Desktop/coding/workExperience/spring/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/springBoard/WEB-INF/lib/spring-webmvc-3.1.1.RELEASE.jar!/META-INF/spring.tld", Long.valueOf(1329370132000L));
    _jspx_dependants.put("jar:file:/C:/Users/82104/Desktop/coding/workExperience/spring/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/springBoard/WEB-INF/lib/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153352682000L));
    _jspx_dependants.put("/WEB-INF/views/common/common.jsp", Long.valueOf(1709601169547L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.release();
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=EUC-KR");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  \r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=EUC-KR\">\r\n");
      out.write("<title></title>\r\n");
      out.write("</head>\r\n");
      out.write("<script src=\"/resources/js/jquery-1.10.2.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("	var $j = jQuery.noConflict();\r\n");
      out.write("</script>\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
      out.write("    \r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=EUC-KR\">\r\n");
      out.write("<title>boardView</title>\r\n");
      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("	.userPwd_ok {\r\n");
      out.write("		font-size: small;\r\n");
      out.write("		color: #008000;\r\n");
      out.write("		display: none;\r\n");
      out.write("	}\r\n");
      out.write("	\r\n");
      out.write("	.userPwd_already {\r\n");
      out.write("		font-size: small;\r\n");
      out.write("		color: rgb(201, 0, 0);\r\n");
      out.write("		display: none;\r\n");
      out.write("	}\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\r\n");
      out.write("	function idChk(){\r\n");
      out.write("		var userId = $j('#userId').val();\r\n");
      out.write("		var checkIdResult = \"\";\r\n");
      out.write("		console.log(userId);\r\n");
      out.write("		\r\n");
      out.write("		const userVo = { // BoardVo 媛�泥� ����\r\n");
      out.write("				\"userId\": userId\r\n");
      out.write("	        };\r\n");
      out.write("		\r\n");
      out.write("			$j.ajax({\r\n");
      out.write("			    url : \"/board/boardUserIdCheckAction.do\",\r\n");
      out.write("			    dataType: \"json\",\r\n");
      out.write("			    type: \"POST\",\r\n");
      out.write("			    contentType: \"application/json; charset=utf-8\",\r\n");
      out.write("			    data : JSON.stringify(userVo),\r\n");
      out.write("			    success: function(userIdCnt)\r\n");
      out.write("			    {\r\n");
      out.write("			    	console.log(userIdCnt);\r\n");
      out.write("			    	alert(userIdCnt);\r\n");
      out.write("			    	\r\n");
      out.write("			    	if(userIdCnt == 0){ //0�대㈃ �ъ�⑷��� 1�대㈃ 以�蹂�\r\n");
      out.write("						alert(\"�ъ�⑺�� �� ���� ���대��������.\");\r\n");
      out.write("						checkIdResult = true;\r\n");
      out.write("			    	} else{ //0�� ����寃쎌��(以�蹂듭�� ��)\r\n");
      out.write("				    	alert(\"以�蹂듬�� ���대��������.\");\r\n");
      out.write("				    	checkIdResult = false;\r\n");
      out.write("			    	}\r\n");
      out.write("					\r\n");
      out.write("			    },\r\n");
      out.write("			    error: function (jqXHR, textStatus, errorThrown)\r\n");
      out.write("			    {\r\n");
      out.write("			    	alert(\"fail\");\r\n");
      out.write("			    }\r\n");
      out.write("			});\r\n");
      out.write("			//ajax end\r\n");
      out.write("			\r\n");
      out.write("			return checkIdResult; //true �몄� false�몄� 諛��� => 異��� if臾몄���� ����\r\n");
      out.write("		};\r\n");
      out.write("\r\n");
      out.write("	function pwChk(){\r\n");
      out.write("		var userPw = $j('#userPw').val();\r\n");
      out.write("		var userPwChk = $j('#userPwChk').val();\r\n");
      out.write("		var checkPwResult = \"\";\r\n");
      out.write("		\r\n");
      out.write("		var pwList=[];\r\n");
      out.write("		\r\n");
      out.write("		console.log(userPw);\r\n");
      out.write("		console.log(userPwChk);\r\n");
      out.write("		\r\n");
      out.write("		pwList.push(userPw);\r\n");
      out.write("		pwList.push(userPwChk);\r\n");
      out.write("		\r\n");
      out.write("			$j.ajax({\r\n");
      out.write("			    url : \"/board/boardUserPwCheckAction.do\",\r\n");
      out.write("			    dataType: \"json\",\r\n");
      out.write("			    type: \"POST\",\r\n");
      out.write("			    contentType: \"application/json; charset=utf-8\",\r\n");
      out.write("			    data : JSON.stringify(pwList),\r\n");
      out.write("			    success: function(userPwCnt)\r\n");
      out.write("			    {\r\n");
      out.write("			    	console.log(userPwCnt);\r\n");
      out.write("			    	alert(userPwCnt);\r\n");
      out.write("			    	\r\n");
      out.write("			    	if (userPwCnt == 1) { //1�대㈃ �쇱�(���몃��)\r\n");
      out.write("						$j('.userPwd_ok').css(\"display\", \"inline-block\");\r\n");
      out.write("						$j('.userPwd_already').css(\"display\", \"none\");\r\n");
      out.write("						checkPwResult = true;\r\n");
      out.write("					} else if (userPwCnt == 0) { // 0 遺��쇱�\r\n");
      out.write("						$j('.userPwd_ok').css(\"display\", \"none\");\r\n");
      out.write("						$j('.userPwd_already').css(\"display\", \"inline-block\");\r\n");
      out.write("						//媛��� 吏��곕㈃ ���몃せ��寃�媛����� 二쇱��泥�由ы��\r\n");
      out.write("						checkPwResult = false;\r\n");
      out.write("					} else { //-1 : controller���� 臾몄��媛� 諛���\r\n");
      out.write("						alert(\"�ㅻ�媛� 諛��������듬����.\");\r\n");
      out.write("					}\r\n");
      out.write("					\r\n");
      out.write("			    },\r\n");
      out.write("			    error: function (jqXHR, textStatus, errorThrown)\r\n");
      out.write("			    {\r\n");
      out.write("			    	console.log(\"fail\");\r\n");
      out.write("			    }\r\n");
      out.write("			});\r\n");
      out.write("			//ajax end\r\n");
      out.write("			\r\n");
      out.write("			return checkPwResult; //true �몄� false�몄� 諛��� => 異��� if臾몄���� ����\r\n");
      out.write("		};\r\n");
      out.write("\r\n");
      out.write("		function handleOnInput(el, maxlength) {\r\n");
      out.write("			if (el.value.length > maxlength) {\r\n");
      out.write("				el.value = el.value.substr(0, maxlength);\r\n");
      out.write("			};\r\n");
      out.write("		};\r\n");
      out.write("		\r\n");
      out.write("		function formCheck(){\r\n");
      out.write("			var regId = /^[a-zA-Z0-9]{6,10}$/;\r\n");
      out.write("			var regIdPw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,12}$/;\r\n");
      out.write("			var form = document.frm;\r\n");
      out.write("			\r\n");
      out.write("			//���대�� ����\r\n");
      out.write("			if (document.frm.userId.value.length == 0) {\r\n");
      out.write("				alert(\"���대��瑜� ���ν�댁＜�몄��.\");\r\n");
      out.write("				document.frm.userId.focus;\r\n");
      out.write("				return false;\r\n");
      out.write("			} else if (!regId.test(document.frm.userId.value)) { //���대�� ���� ����臾몄�� ����\r\n");
      out.write("				alert(\"6~10�� ��臾� ����臾몄��, �レ��留� ���ν�댁＜�몄��.\")\r\n");
      out.write("				userId.focus();\r\n");
      out.write("				return false;\r\n");
      out.write("			} else if (!idChk()) {\r\n");
      out.write("				alert(\"���대��瑜� �ㅼ�� ���명�댁＜�몄��.\");\r\n");
      out.write("				return false;\r\n");
      out.write("			}\r\n");
      out.write("			\r\n");
      out.write("			//鍮�諛�踰��� ����\r\n");
      out.write("			else if (document.frm.userPw.value.length == 0) {\r\n");
      out.write("				alert(\"鍮�諛�踰��몃�� ���ν���몄��.\")\r\n");
      out.write("				userPw.focus();\r\n");
      out.write("				return false;\r\n");
      out.write("			} else if (!regIdPw.test(document.frm.userPw.value)) {\r\n");
      out.write("				alert(\"6~10�� ��臾� ����臾몄��, �レ��, �뱀��臾몄��瑜� ���ν�댁＜�몄��.\")\r\n");
      out.write("				userPw.focus();\r\n");
      out.write("				return false;\r\n");
      out.write("			} else if (document.frm.userPw.value == document.frm.userId.value) {\r\n");
      out.write("				alert(\"���대���� ���쇳�� 鍮�諛�踰��몃�� �ъ�⑺�� �� ���듬����.\")\r\n");
      out.write("				userPw.focus();\r\n");
      out.write("				return false;\r\n");
      out.write("			} else if (!checkPw()) {\r\n");
      out.write("				alert(\"鍮�諛�踰��몃�� �ㅼ�� ���명�댁＜�몄��.\");\r\n");
      out.write("				return false;\r\n");
      out.write("			}else if (document.frm.userPhone1.value.length == 0) {\r\n");
      out.write("				alert(\"�대������踰��몃�� �ㅼ�� ���명�댁＜�몄��.\")\r\n");
      out.write("				document.frm.userPhone1.focus;\r\n");
      out.write("				return false;\r\n");
      out.write("			} else if (document.frm.userPhone2.value.length == 0\r\n");
      out.write("					|| document.frm.userPhone2.value.length < 4) {\r\n");
      out.write("				alert(\"�대������踰��� 媛��대�� ��由щ�� �ㅼ�� ���명�댁＜�몄��(4湲���).\")\r\n");
      out.write("				document.frm.userPhone2.focus;\r\n");
      out.write("				return false;\r\n");
      out.write("			} else if (document.frm.userPhone3.value.length == 0\r\n");
      out.write("					|| document.frm.userPhone3.value.length < 4) {\r\n");
      out.write("				alert(\"�대������踰��� 留�吏�留� ��由щ�� �ㅼ�� ���명�댁＜�몄��(4湲���).\")\r\n");
      out.write("				document.frm.userPhone3.focus;\r\n");
      out.write("				return false;\r\n");
      out.write("			} else if (document.frm.userAddr1.value.length == 0) {\r\n");
      out.write("				alert(\"�고�몃��몃�� �ㅼ�� ���명�댁＜�몄��.\")\r\n");
      out.write("				document.frm.userAddr1.focus;\r\n");
      out.write("				return false;\r\n");
      out.write("			} else if (document.frm.userAddr2.value.length == 0) {\r\n");
      out.write("				alert(\"二쇱��瑜� �ㅼ�� ���명�댁＜�몄��.\")\r\n");
      out.write("				document.frm.userAddr2.focus;\r\n");
      out.write("				return false;\r\n");
      out.write("			}\r\n");
      out.write("			//disabled=\"disabled\"\r\n");
      out.write("			submitButton.disabled = 'disable';\r\n");
      out.write("			//spinner.type = 'text';\r\n");
      out.write("\r\n");
      out.write("			form.submit();\r\n");
      out.write("		}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("<table  align=\"center\" id=\"wrapTable\">\r\n");
      out.write("	<tr id=\"inform\">\r\n");
      out.write("		<td align=\"left\">\r\n");
      out.write("			<a href=\"/board/boardList.do\">List</a> \r\n");
      out.write("		</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("	<tr>\r\n");
      out.write("		<td>\r\n");
      out.write("			<table id=\"boardTable\" border = \"1\">\r\n");
      out.write("				<tr>\r\n");
      out.write("					<td width=\"120\" align=\"center\">\r\n");
      out.write("						id\r\n");
      out.write("					</td>\r\n");
      out.write("					<td width=\"300\">\r\n");
      out.write("					<input type=\"text\" id=\"userId\" name=\"userId\" maxlength=\"5\">\r\n");
      out.write("					<button id=\"idChk\" onclick=\"return idChk()\">Duplicate Check</button>\r\n");
      out.write("					</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("\r\n");
      out.write("				<tr>\r\n");
      out.write("					<td align=\"center\">\r\n");
      out.write("						pw\r\n");
      out.write("					</td>\r\n");
      out.write("					<td>\r\n");
      out.write("					<input type=\"password\" name=\"userPw\" id=\"userPw\" maxlength=\"12\" onkeydown=\"return pwChk()\">\r\n");
      out.write("					</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("\r\n");
      out.write("				<tr>\r\n");
      out.write("					<td align=\"center\">\r\n");
      out.write("						pw check\r\n");
      out.write("					</td>\r\n");
      out.write("					<td>\r\n");
      out.write("					<input type=\"password\" name=\"userPwChk\" id=\"userPwChk\" maxlength=\"12\" onchange=\"return pwChk()\" >\r\n");
      out.write("					<span\r\n");
      out.write("								class=\"userPwd_ok\">&nbsp;&nbsp;success</span> <span\r\n");
      out.write("								class=\"userPwd_already\">&nbsp;&nbsp;fail</span>\r\n");
      out.write("					</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("\r\n");
      out.write("				<tr>\r\n");
      out.write("					<td align=\"center\">\r\n");
      out.write("						name\r\n");
      out.write("					</td>\r\n");
      out.write("					<td>\r\n");
      out.write("					<input type=\"text\" name=\"userName\">\r\n");
      out.write("					</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("\r\n");
      out.write("				<tr>\r\n");
      out.write("					<td align=\"center\">\r\n");
      out.write("						phone\r\n");
      out.write("					</td>\r\n");
      out.write("					<td >\r\n");
      out.write("					<select name=\"userPhone1\">\r\n");
      out.write("						");
      if (_jspx_meth_c_005fforEach_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("					</select>\r\n");
      out.write("					<input type=\"text\" name=\"userPhone2\" style=\"width: 40px\" maxlength=\"4\"\r\n");
      out.write("					oninput=\"this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\\..*)\\./g, '$1')\">\r\n");
      out.write("					-\r\n");
      out.write("					<input type=\"text\" name=\"userPhone3\" style=\"width: 40px\" maxlength=\"4\"\r\n");
      out.write("					oninput=\"this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\\..*)\\./g, '$1')\">\r\n");
      out.write("					</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("\r\n");
      out.write("				<tr>\r\n");
      out.write("					<td align=\"center\">\r\n");
      out.write("						postNo\r\n");
      out.write("					</td>\r\n");
      out.write("					<td >\r\n");
      out.write("					<input type=\"text\" name=\"userAddr1\">\r\n");
      out.write("					</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("\r\n");
      out.write("				<tr >\r\n");
      out.write("					<td align=\"center\" align=\"center\">\r\n");
      out.write("						address\r\n");
      out.write("					</td>\r\n");
      out.write("					<td>\r\n");
      out.write("					<input type=\"text\" name=\"userAddr2\">\r\n");
      out.write("					</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("\r\n");
      out.write("				<tr >\r\n");
      out.write("					<td align=\"center\">\r\n");
      out.write("						company\r\n");
      out.write("					</td>\r\n");
      out.write("					<td>\r\n");
      out.write("					<input type=\"text\" name=\"userCompany\">\r\n");
      out.write("					</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("\r\n");
      out.write("			</table>\r\n");
      out.write("		</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("	\r\n");
      out.write("	<tr>\r\n");
      out.write("		<td align=\"right\">\r\n");
      out.write("			<a href =\"/board/boardWrite.do\">join</a>\r\n");
      out.write("		</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("</table>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_c_005fforEach_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    boolean _jspx_th_c_005fforEach_005f0_reused = false;
    try {
      _jspx_th_c_005fforEach_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f0.setParent(null);
      // /WEB-INF/views/board/boardJoin.jsp(244,6) name = items type = javax.el.ValueExpression reqTime = true required = false fragment = false deferredValue = true expectedTypeName = java.lang.Object deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f0.setItems(new org.apache.jasper.el.JspValueExpression("/WEB-INF/views/board/boardJoin.jsp(244,6) '${codeList}'",_jsp_getExpressionFactory().createValueExpression(_jspx_page_context.getELContext(),"${codeList}",java.lang.Object.class)).getValue(_jspx_page_context.getELContext()));
      // /WEB-INF/views/board/boardJoin.jsp(244,6) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f0.setVar("codeList");
      int[] _jspx_push_body_count_c_005fforEach_005f0 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f0 = _jspx_th_c_005fforEach_005f0.doStartTag();
        if (_jspx_eval_c_005fforEach_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("							<option value=\"");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${codeList.codeId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
            out.write('"');
            out.write('>');
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${codeList.codeName}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
            out.write("</option>						\r\n");
            out.write("						");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f0.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return true;
        }
      } catch (java.lang.Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f0[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f0.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f0.doFinally();
      }
      _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.reuse(_jspx_th_c_005fforEach_005f0);
      _jspx_th_c_005fforEach_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fforEach_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fforEach_005f0_reused);
    }
    return false;
  }
}