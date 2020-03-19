package com.tongyong.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tongyong.exception.CustomException;
import com.tongyong.pojo.entity.addition.LoginUser;
import com.tongyong.process.context.MyConfig;
import com.tongyong.process.result.ResultInfo;
import com.tongyong.service.IUserService;

/**
 * 
 * <p>Title: LoginController</p>
 * <p>Description: 登陆和退出</p>
 * <p>Company: www.itcast.com</p> 
 * @author	xie
 * @date	2015-3-22下午4:43:26
 * @version 1.0
 */
@Controller
public class LoginController {
	
	@Autowired
	private IUserService sysService;
	
	
	//用户登陆提交方法
	/**
	 * 
	 * <p>Title: login</p>
	 * <p>Description: </p>
	 * @param session
	 * @param randomcode 输入的验证码
	 * @param usercode 用户账号
	 * @param password 用户密码 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login(Model model){
		return "login";
	}
	@RequestMapping(value="/validatecode",method=RequestMethod.GET)
	public String validatecode(Model model){
		return "validatecode";
	}
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public String login(HttpSession session, String randomcode,String username,String password)throws Exception{
		
		//校验验证码，防止恶性攻击
		//从session获取正确验证码
		String validateCode = (String) session.getAttribute("validateCode");
		
		//输入的验证和session中的验证进行对比 
		if(!randomcode.equals(validateCode)){
			//抛出异常
			throw new CustomException(new ResultInfo(1,3,"验证码输入错误"));
		}
		
		//调用service校验用户账号和密码的正确性
		LoginUser loginUser = sysService.authenticat(username, password);
		
		//如果service校验通过，将用户身份记录到session
		session.setAttribute(MyConfig.LOGINUSER_KEY, loginUser);
		//session.setAttribute("loginUser", loginUser);
		//重定向到商品查询页面
		return "redirect:/index.action";
	}
	
	//登陆提交地址，和applicationContext-shiro.xml中配置的loginurl一致
	@RequestMapping("login1")
	public String login(HttpServletRequest request)throws Exception{
		
		//如果登陆失败从request中获取认证异常信息，shiroLoginFailure就是shiro异常类的全限定名
		String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
		//根据shiro返回的异常类路径判断，抛出指定异常信息
		if(exceptionClassName!=null){
			if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
				//最终会抛给异常处理器
				throw new CustomException(new ResultInfo(1,1,"账号不存在"));
			} else if (IncorrectCredentialsException.class.getName().equals(
					exceptionClassName)) {
				throw new CustomException(new ResultInfo(1,2,"用户名/密码错误"));
			} else if("randomCodeError".equals(exceptionClassName)){
				throw new CustomException(new ResultInfo(1,3,"验证码错误 "));
			}else {
				throw new Exception();//最终在异常处理器生成未知错误
			}
		}
		//此方法不处理登陆成功（认证成功），shiro认证成功会自动跳转到上一个请求路径
		//登陆失败还到login页面
		return "login";
	}
	//主界面
		@RequestMapping("/index")
		public String index(Model model,HttpSession session) {
			//登录后的默认欢迎页面
			String url="/welcome.action";
			
			//FIXME 根据登录用户的角色判断去哪个欢迎界面
			LoginUser loginUser=(LoginUser) session.getAttribute(MyConfig.LOGINUSER_KEY);
			//loginUser=(LoginUser) session.getAttribute(MyConfig.LOGINUSER_KEY);
			model.addAttribute("welcomeUrl", url);
			System.out.println("asdfsadfasdf");
			System.out.println(loginUser.getMenus());
			model.addAttribute("loginUser", loginUser);
			
			// 去主界面，拦截器中控制，如果没有登录，是访问不了它
			return "index";
		}
		
		//欢迎界面
		@RequestMapping("/welcome")
		public String welcome(){
			return "welcome";
		}
	//用户退出
	@RequestMapping("/logout")
	public String logout(HttpSession session)throws Exception{
		
		//session失效
		session.invalidate();
		//重定向到商品查询页面
		return "redirect:/login.action";
		
	}
	

}
