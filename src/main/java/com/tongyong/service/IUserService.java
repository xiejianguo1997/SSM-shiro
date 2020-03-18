package com.tongyong.service;

import com.tongyong.pojo.entity.addition.UserCustom;
import com.tongyong.pojo.entity.addition.UserQuery;
import com.tongyong.pojo.entity.User;

/**
 * 用户-业务逻辑层接口
 * @author sunmeng
 * @date 2016年6月17日 上午11:39:43
 */
public interface IUserService extends IBaseService<User, UserQuery, UserCustom>{

	/**
	 * 判断用户名是否存在
	 * @author sunmeng
	 * @date 2016年6月17日 上午11:28:01
	 * @param name
	 * @return
	 * @throws Exception
	 */
	boolean isExists(String username) throws Exception;

	/**
	 * 批量禁用
	 * @author sunmeng
	 * @date 2016年6月17日 下午2:49:20
	 * @param ids
	 */
	void userBatchDisable(int[] ids);
	
	/**
	 * 根据用户名查找用户
	 * @author monkey
	 * @date 2016年6月22日 上午10:19:13
	 * @param username
	 * @return
	 * @throws Exception
	 */
	public UserCustom selectByUsername(String username)throws Exception;

	/**
	 * 修改密码
	 * @author sunmeng
	 * @date 2016年12月30日 上午11:17:19
	 * @param userId
	 * @param md5NewPassword
	 */
	void updatePassword(Integer userId,String md5NewPassword);
}
