/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.78
 * Generated at: 2024-03-06 07:12:22 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.board;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class boardSearch_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=EUC-KR\">\r\n");
      out.write("<title>list</title>\r\n");
      out.write("</head>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("$j(document).ready(function(){\r\n");
      out.write("	 $j(\"#search\").on(\"click\", function(e){\r\n");
      out.write("		\r\n");
      out.write("		 var boardTypes = $j(\"input:checkbox[name='menu']:checked\");\r\n");
      out.write("		 var boardList = [];\r\n");
      out.write("\r\n");
      out.write("		 boardTypes.each(function(){\r\n");
      out.write("               var type = $j(this).attr('id');\r\n");
      out.write("               \r\n");
      out.write("               /* const boardVo = {\r\n");
      out.write("  					 \"boardType\": type\r\n");
      out.write("  				 };\r\n");
      out.write("  				 \r\n");
      out.write("               boardList.push(boardVo);\r\n");
      out.write("				 */\r\n");
      out.write("               boardList.push(type);\r\n");
      out.write("               console.log(boardList);\r\n");
      out.write("           });\r\n");
      out.write("\r\n");
      out.write("	        // 폼 생성\r\n");
      out.write("	        var formData = $j(\"<form>\")\r\n");
      out.write("	            .attr(\"method\", \"GET\")  // GET 요청으로 변경\r\n");
      out.write("	            .attr(\"action\", \"/board/boardSearch.do\");\r\n");
      out.write("\r\n");
      out.write("	        // boardList의 각 요소에 대해 숨겨진 입력 요소 생성 및 설정\r\n");
      out.write("	        boardList.forEach(function(boardVo, index) {\r\n");
      out.write("	            $j(\"<input>\")\r\n");
      out.write("	                .attr(\"type\", \"hidden\")\r\n");
      out.write("	                .attr(\"name\", \"boardTypes\")\r\n");
      out.write("	                .val(boardVo)\r\n");
      out.write("	                .appendTo(formData);\r\n");
      out.write("	        });\r\n");
      out.write("\r\n");
      out.write("	        // 생성된 폼을 body에 추가하고 제출\r\n");
      out.write("	        formData.appendTo(\"body\").submit();	        \r\n");
      out.write("       \r\n");
      out.write("       \r\n");
      out.write("	});\r\n");
      out.write("}); \r\n");
      out.write("\r\n");
      out.write("//전체선택\r\n");
      out.write("function selectAll(selectAll){\r\n");
      out.write("	const checkboxes = document.getElementsByName('menu');\r\n");
      out.write("	checkboxes.forEach((checkbox) => {\r\n");
      out.write("		checkbox.checked = selectAll.checked;\r\n");
      out.write("	});\r\n");
      out.write("};\r\n");
      out.write("\r\n");
      out.write("//하나라도 체크되지 않으면 전체 선택이 해제되고 전부 체크하면 전체선택이 체크\r\n");
      out.write("function checkSelectAll(){\r\n");
      out.write("	//전체 체크 박스\r\n");
      out.write("	const checkboxes = document.querySelectorAll(\"input[name='menu']\");\r\n");
      out.write("	const checked = $j(\"input:checkbox[name=menu]:checked\");\r\n");
      out.write("	\r\n");
      out.write("	//select all 체크 박스\r\n");
      out.write("	const selectAll = document.querySelector(\"input[name='selectall']\");\r\n");
      out.write("	\r\n");
      out.write("	if( (checkboxes.length === checked.length) ){\r\n");
      out.write("		selectAll.checked = true;\r\n");
      out.write("	} else {\r\n");
      out.write("		selectAll.checked = false;\r\n");
      out.write("	}\r\n");
      out.write("};\r\n");
      out.write("\r\n");
      out.write("	\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("<body>\r\n");
      out.write("<table  align=\"center\">\r\n");
      out.write("	<tr>\r\n");
      out.write("		<td align=\"left\">\r\n");
      out.write("			<a href=\"\"> login</a> \r\n");
      out.write("			<a href=\"/board/boardJoin\"> join</a> \r\n");
      out.write("		</td>\r\n");
      out.write("		<td align=\"right\">\r\n");
      out.write("			total : ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${totalCnt}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("\r\n");
      out.write("		</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("	<tr>\r\n");
      out.write("		<td>\r\n");
      out.write("			<table id=\"boardTable\" border = \"1\">\r\n");
      out.write("				<tr>\r\n");
      out.write("					<td width=\"80\" align=\"center\">\r\n");
      out.write("						Type\r\n");
      out.write("					</td>\r\n");
      out.write("					<td width=\"40\" align=\"center\">\r\n");
      out.write("						No\r\n");
      out.write("					</td>\r\n");
      out.write("					<td width=\"300\" align=\"center\">\r\n");
      out.write("						Title\r\n");
      out.write("					</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("				");
      if (_jspx_meth_c_005fforEach_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("			</table>\r\n");
      out.write("		</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("	\r\n");
      out.write("		<tr>\r\n");
      out.write("		<td align=\"center\">\r\n");
      out.write("			<input type=\"checkbox\" id=\"select_all\" name=\"selectall\" onclick=\"selectAll(this)\" >전체\r\n");
      out.write("			<input type=\"checkbox\" id=\"a01\" name=\"menu\" onclick=\"return checkSelectAll()\" value=\"selectall\">일반\r\n");
      out.write("			<input type=\"checkbox\" id=\"a02\" name=\"menu\" onclick=\"return checkSelectAll()\" value=\"selectall\">Q&A\r\n");
      out.write("			<input type=\"checkbox\" id=\"a03\" name=\"menu\" onclick=\"return checkSelectAll()\" value=\"selectall\">익명\r\n");
      out.write("			<input type=\"checkbox\" id=\"a04\" name=\"menu\" onclick=\"return checkSelectAll()\" value=\"selectall\">자유\r\n");
      out.write("			\r\n");
      out.write("			<input id=\"search\" type=\"button\" value=\"조회\"  >\r\n");
      out.write("			<!-- onclick=\"location.href='/board/boardSearch.do'\" -->\r\n");
      out.write("		</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("	\r\n");
      out.write("		\r\n");
      out.write("	<tr>\r\n");
      out.write("		<td align=\"right\">\r\n");
      out.write("			<a href =\"/board/boardList.do\">전체목록보기</a>\r\n");
      out.write("			<a href =\"/board/boardWrite.do\">글쓰기</a>\r\n");
      out.write("		</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("</table>	\r\n");
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
      // /WEB-INF/views/board/boardSearch.jsp(105,4) name = items type = javax.el.ValueExpression reqTime = true required = false fragment = false deferredValue = true expectedTypeName = java.lang.Object deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f0.setItems(new org.apache.jasper.el.JspValueExpression("/WEB-INF/views/board/boardSearch.jsp(105,4) '${boardList}'",_jsp_getExpressionFactory().createValueExpression(_jspx_page_context.getELContext(),"${boardList}",java.lang.Object.class)).getValue(_jspx_page_context.getELContext()));
      // /WEB-INF/views/board/boardSearch.jsp(105,4) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f0.setVar("list");
      int[] _jspx_push_body_count_c_005fforEach_005f0 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f0 = _jspx_th_c_005fforEach_005f0.doStartTag();
        if (_jspx_eval_c_005fforEach_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("					<tr>\r\n");
            out.write("						<td align=\"center\">\r\n");
            out.write("							");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${list.boardType}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
            out.write("\r\n");
            out.write("						</td>\r\n");
            out.write("						<td>\r\n");
            out.write("							");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${list.boardNum}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
            out.write("\r\n");
            out.write("						</td>\r\n");
            out.write("						<td>\r\n");
            out.write("							<a href = \"/board/");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${list.boardType}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
            out.write('/');
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${list.boardNum}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
            out.write("/boardView.do?pageNo=");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageNo}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
            out.write('"');
            out.write('>');
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${list.boardTitle}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
            out.write("</a>\r\n");
            out.write("						</td>\r\n");
            out.write("					</tr>	\r\n");
            out.write("				");
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
