package com.tongyong.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tongyong.pojo.entity.addition.UserCustom;
import com.tongyong.pojo.entity.addition.UserQuery;
import com.tongyong.pojo.entity.User;

/**
 * 用户-数据访问层接口
 * @author sunmeng
 * @date 2017年1月4日上午11:40:08
 */
public interface UserMapper extends BaseMapper<User, UserQuery, UserCustom>{

	/**
	 * 根据用户名查询记录数
	 * @author sunmeng
	 * @date 2016年6月17日 上午11:29:58
	 * @param username
	 * @return
	 */
	int selectCountByUsername(String username);

	/**
	 * 批量禁用
	 * @author sunmeng
	 * @date 2016年6月17日 下午2:50:34
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
	
	List<User> setlectTempList(User user);

	/**
	 * 修改密码
	 * @author sunmeng
	 * @date 2016年12月30日 上午11:18:56
	 * @param userId
	 * @param md5NewPassword
	 */
	void updatePassword(@Param("userId")Integer userId,@Param("md5NewPassword")String md5NewPassword);
}