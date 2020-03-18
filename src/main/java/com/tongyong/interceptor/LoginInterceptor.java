package com.tongyong.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


import com.tongyong.pojo.entity.addition.LoginUser;
import com.tongyong.process.context.MyConfig;
import com.tongyong.process.result.ResourcesUtil;
import com.tongyong.process.result.ResultUtil;


/**
 * 用户的认证拦截器
 * @author monkey
 * @date 2016�?6�?23�? 上午10:21:48
 */
public class LoginInterceptor implements HandlerInterceptor {

	// 进入handler之前
	// 使用：用户的认证、用户的授权
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//校验用户身份是否合法，也就是判断用户是否登录
		HttpSession session=request.getSession();
		//LoginUser loginUser=(LoginUser) session.getAttribute(MyConfig.LOGINUSER_KEY);
		LoginUser loginUser=(LoginUser) session.getAttribute(MyConfig.LOGINUSER_KEY);
		if (loginUser!=null) {
			//登录了就放行
			return true;
		}
		
		//获取请求的url地址
		String requestUrl=request.getRequestURI();
		
		//没登录的时�?�，判断是否访问公共资源，这这个ResourcesUtil还有读取单条配置信息的方法getValue
		List<String> openUrls=ResourcesUtil.gekeyList(MyConfig.ANONYMOUS_URL);
		for (String openUrl : openUrls) {
			if (requestUrl.indexOf(openUrl)>-1) {
				return true;
			}
		}
		
		//到了这里�?定是没有登录，同时访问的是非匿名地址，那么直接去登录页面
		//request.getRequestDispatcher("/logout.jsp").forward(request, response);
		//抛出异常的方式可以解决用户ajax提交时会有登录失效提�?
		//FIXME 在ResultUtil中封装一个登录失效方法，�?要修改js中加入登录失效提示，ResultInfo也要加一个分类就是失�?
		ResultUtil.throwCustomExcepion(MyConfig.LOGIN_FAILURE);//没有登录抛出未登录异�?
		
		return false;
	}

	// 进入action之后，返回modelAndView之前
	// 使用：这里对统一返回数据进行处理，比如统�?添加菜单导航
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	// action执行完成，以后返回modelAndView�?
	// 使用：统�?异常处理，在这里统一记录系统日志。监控action执行时间，在preHandle和afterCompletion记录两个时间做对�?
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
