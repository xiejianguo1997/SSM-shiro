/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2020-03-05 09:08:18 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.release();
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\n');
      out.write('\n');
      if (_jspx_meth_c_005fset_005f0(_jspx_page_context))
        return;
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("  <meta charset=\"utf-8\">\n");
      out.write("  <title>HTML5</title>\n");
      out.write("  <script>if(window.top !== window.self){ window.top.location = window.location;}</script>\n");
      out.write("  <meta name=\"description\" content=\"particles.js is a lightweight JavaScript library for creating particles.\">\n");
      out.write("  <meta name=\"author\" content=\"Vincent Garreau\" />\n");
      out.write("  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\">\n");
      out.write("  <link rel=\"stylesheet\" media=\"screen\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectPath }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/css/style.css\">\n");
      out.write("  <link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectPath }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/css/reset.css\"/>\n");
      out.write("  <style type=\"text/css\">\n");
      out.write("\t.login .errorTips{height: 30px; line-height: 30px; font-size: 16px; color: #f66; margin-top: 20px;}\n");
      out.write("  </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<div id=\"particles-js\">\n");
      out.write("\t\t<div class=\"login\">\n");
      out.write("\t\t\t<form action=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectPath }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/login.action\" method=\"post\">\n");
      out.write("\t\t\t<div class=\"login-top\">\n");
      out.write("\t\t\t登录\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t\t<div class=\"login-center clearfix\">\n");
      out.write("\t\t\t\t<div class=\"login-center-img\"><img src=\"img/name.png\"/></div>\n");
      out.write("\t\t\t\t<div class=\"login-center-input\">\n");
      out.write("\t\t\t\t\t<input type=\"text\" name=\"username\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${username }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\" placeholder=\"请输入您的用户名\" onfocus=\"this.placeholder=''\" onblur=\"this.placeholder='请输入您的用户名'\"/>\n");
      out.write("\t\t\t\t\t<div class=\"login-center-input-text\">用户名</div>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t\t<div class=\"login-center clearfix\">\n");
      out.write("\t\t\t\t<div class=\"login-center-img\"><img src=\"img/password.png\"/></div>\n");
      out.write("\t\t\t\t<div class=\"login-center-input\">\n");
      out.write("\t\t\t\t\t<input type=\"password\" name=\"password\" placeholder=\"请输入您的密码\" onfocus=\"this.placeholder=''\" onblur=\"this.placeholder='请输入您的密码'\"/>\n");
      out.write("\t\t\t\t\t<div class=\"login-center-input-text\">密 码</div>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t\t<div class=\"login-center\">\n");
      out.write("\t\t\t<div class=\"errorTips\" >");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${msg }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("</div>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t\t<div class=\"login-button\">\n");
      out.write("\t\t\t<input type=\"submit\" value=\"登录\">\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</div>\n");
      out.write("\t\t</form>\n");
      out.write("\t\t<div class=\"sk-rotating-plane\"></div>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<!-- scripts -->\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectPath }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/js/particles.min.js\"></script>\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectPath }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/js/app.js\"></script>\n");
      out.write("<script type=\"text/javascript\">\n");
      out.write("\tfunction hasClass(elem, cls) {\n");
      out.write("\t  cls = cls || '';\n");
      out.write("\t  if (cls.replace(/\\s/g, '').length == 0) return false; //å½clsæ²¡æåæ°æ¶ï¼è¿åfalse\n");
      out.write("\t  return new RegExp(' ' + cls + ' ').test(' ' + elem.className + ' ');\n");
      out.write("\t}\n");
      out.write("\t \n");
      out.write("\tfunction addClass(ele, cls) {\n");
      out.write("\t  if (!hasClass(ele, cls)) {\n");
      out.write("\t    ele.className = ele.className == '' ? cls : ele.className + ' ' + cls;\n");
      out.write("\t  }\n");
      out.write("\t}\n");
      out.write("\t \n");
      out.write("\tfunction removeClass(ele, cls) {\n");
      out.write("\t  if (hasClass(ele, cls)) {\n");
      out.write("\t    var newClass = ' ' + ele.className.replace(/[\\t\\r\\n]/g, '') + ' ';\n");
      out.write("\t    while (newClass.indexOf(' ' + cls + ' ') >= 0) {\n");
      out.write("\t      newClass = newClass.replace(' ' + cls + ' ', ' ');\n");
      out.write("\t    }\n");
      out.write("\t    ele.className = newClass.replace(/^\\s+|\\s+$/g, '');\n");
      out.write("\t  }\n");
      out.write("\t}\n");
      out.write("\t\tdocument.querySelector(\".login-button\").onclick = function(){\n");
      out.write("\t\t\t\taddClass(document.querySelector(\".login\"), \"active\")\n");
      out.write("\t\t\t\tsetTimeout(function(){\n");
      out.write("\t\t\t\t\taddClass(document.querySelector(\".sk-rotating-plane\"), \"active\")\n");
      out.write("\t\t\t\t\tdocument.querySelector(\".login\").style.display = \"none\"\n");
      out.write("\t\t\t\t},800)\n");
      out.write("\t\t\t\tsetTimeout(function(){\n");
      out.write("\t\t\t\t\tremoveClass(document.querySelector(\".login\"), \"active\")\n");
      out.write("\t\t\t\t\tremoveClass(document.querySelector(\".sk-rotating-plane\"), \"active\")\n");
      out.write("\t\t\t\t\tdocument.querySelector(\".login\").style.display = \"block\"\n");
      out.write("\t\t\t\t\t//alert(\"ç»å½æå\")\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t\t},5000)\n");
      out.write("\t\t}\n");
      out.write("</script>\n");
      out.write("<div style=\"text-align:center;\">\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_c_005fset_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f0 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    _jspx_th_c_005fset_005f0.setPageContext(_jspx_page_context);
    _jspx_th_c_005fset_005f0.setParent(null);
    // /WEB-INF/jsp/login.jsp(3,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fset_005f0.setVar("projectPath");
    // /WEB-INF/jsp/login.jsp(3,0) name = value type = javax.el.ValueExpression reqTime = true required = false fragment = false deferredValue = true expectedTypeName = java.lang.Object deferredMethod = false methodSignature = null
    _jspx_th_c_005fset_005f0.setValue(new org.apache.jasper.el.JspValueExpression("/WEB-INF/jsp/login.jsp(3,0) '${pageContext.request.contextPath }'",_el_expressionfactory.createValueExpression(_jspx_page_context.getELContext(),"${pageContext.request.contextPath }",java.lang.Object.class)).getValue(_jspx_page_context.getELContext()));
    int _jspx_eval_c_005fset_005f0 = _jspx_th_c_005fset_005f0.doStartTag();
    if (_jspx_th_c_005fset_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f0);
    return false;
  }
}
