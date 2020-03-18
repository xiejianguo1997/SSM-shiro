package com.tongyong.exception;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.http.HttpOutputMessage;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.tongyong.process.context.MyConfig;
import com.tongyong.process.result.ResultInfo;
import com.tongyong.process.result.SubmitResultInfo;

/**
 * 统一的异常处理器类
 * 
 * @author monkey
 * @date 2016年6月7日 下午3:14:08
 */
public class CustomExceptionResolver implements HandlerExceptionResolver {

	// 记录错误日志
	static Logger logger = Logger.getLogger(Logger.class);

	// json转换器，将异常信息转json，通过spring注入，在spingmvc中配置
	private HttpMessageConverter<SubmitResultInfo> jsonMessageConverter;

	public HttpMessageConverter<SubmitResultInfo> getJsonMessageConverter() {
		return jsonMessageConverter;
	}

	public void setJsonMessageConverter(HttpMessageConverter<SubmitResultInfo> jsonMessageConverter) {
		this.jsonMessageConverter = jsonMessageConverter;
	}

	// 统一处理异常信息
	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {

		// 记录错误日志
		writeErrorUseLog4j(ex);

		// 转成springmvc底层对象（就是对action方法的封装对象，只有一个方法）
		HandlerMethod handlerMethod = (HandlerMethod) handler;

		Method method = handlerMethod.getMethod();// 取出方法

		// 判断方法是否返回json，方法上有responsebody注解就表示返回json，查询method是否有responsebody注解
		ResponseBody responseBody = AnnotationUtils.findAnnotation(method, ResponseBody.class);
		if (responseBody != null) {
			// 此方法返回json，所以需要将异常信息转换为json输出
			return this.resolveJsonException(request, response, handler, ex);
		}

		// 返回的不是json，就是页面
		CustomException customException = this.resolveCustomException(ex);// 解析异常信息

		String view = MyConfig.ERROR_PAGE_URL;// 错误页面

		// 异常代码
		int messageCode = customException.getResultInfo().getMessageCode();
		if (messageCode == MyConfig.LOGIN_FAILURE) {
			// 跳转到登陆（正式做需要修改），因为我的页面不在这里
			view =MyConfig.LOGOUT_PAGE_URL;
		}
		//没有权限
		if (messageCode==MyConfig.NO_PERMISSION) {
			view=MyConfig.REFUSE_PAGE_URL;
		}
		
		// 转向错误页面，错误信息保存到ModelAndView，在页面就可以取到
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("exceptionResultInfo", customException.getResultInfo());
		modelAndView.setViewName(view);
		
		return modelAndView;
	}

	/**
	 * 把异常信息通过log4j记录到到日志文件中
	 * 
	 * @author monkey
	 * @date 2016年6月7日 下午3:26:43
	 * @param ex
	 */
	private void writeErrorUseLog4j(Exception ex) {

		// 把ex.printStackTrace()打印的内容输出为字符串，并用log4j记录，记得关闭流
		StringWriter stringWriter = new StringWriter();
		PrintWriter printWriter = new PrintWriter(stringWriter);
		try {
			ex.printStackTrace(printWriter);// 打印到输出流
			logger.error(stringWriter.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			printWriter.close();
			try {
				stringWriter.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 解析异常信息
	 * 
	 * @author monkey
	 * @date 2016年6月7日 下午3:37:44
	 * @param ex
	 * @return
	 */
	private CustomException resolveCustomException(Exception ex) {
		// 判断是否是自定义异常，如果是就返回，否则就构造一个自定义异常
		ResultInfo resultInfo = null;
		// 判断异常是否自定义异常
		if (ex instanceof CustomException) {
			resultInfo = ((CustomException) ex).getResultInfo();
		} else {
			resultInfo = new ResultInfo();
			resultInfo.setType(ResultInfo.TYPE_RESULT_FAIL);
			resultInfo.setMessage("未知异常！");
		}

		return new CustomException(resultInfo);
	}
	
	/**
	 * 将异常信息转换为json输出
	 * 
	 * @author monkey
	 * @date 2016年6月7日 下午3:44:08
	 * @param request
	 * @param response
	 * @param handler
	 * @param ex
	 * @return
	 */
	private ModelAndView resolveJsonException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		// 解析异常
		CustomException customException=this.resolveCustomException(ex);
		
		//响应
		HttpOutputMessage outputMessage=new ServletServerHttpResponse(response);
		
		//构造一个系统提交后统一响应结果类型来响应，直接响应CustomException，信息太多了。因为它继承Exception
		SubmitResultInfo submitResultInfo=new SubmitResultInfo(customException.getResultInfo());
		
		// 将submitResultInfo对象转成json输出
		try {
			//jsonMessageConverter是一个专门的工具类			
			//缓存输出submitResultInfo这个类，信息少很多，这是专门的响应类
			jsonMessageConverter.write(submitResultInfo, MediaType.APPLICATION_JSON, outputMessage);
		} catch (HttpMessageNotWritableException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return new ModelAndView();
	}
}
