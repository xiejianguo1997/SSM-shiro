package com.tongyong.service;

import java.util.List;

import com.tongyong.pojo.entity.addition.DepartmentCustom;
import com.tongyong.pojo.entity.addition.DepartmentQuery;
import com.tongyong.pojo.entity.Department;

/**
 * 部门-业务逻辑层接口
 * @author monkey
 * @date 2016年6月3日 上午11:06:39
 */
public interface IDepartmentService {
	
	/**
	 * 新增一条数据
	 * @author monkey
	 * @date 2016年6月3日 上午11:11:21
	 * @param record
	 * @return
	 */
	int insert(Department record) throws Exception;
	
	/**
	 * 修改一条记录
	 * @author monkey
	 * @date 2016年6月7日 上午9:31:19
	 * @param record
	 * @return
	 * @throws Exception
	 */
	int update(Department record)throws Exception;
	
	/**
	 * 根据id查询单条记录
	 * @author monkey
	 * @date 2016年6月3日 上午10:49:40
	 * @param id 主键
	 * @return 返回查询到的实体
	 * @throws Exception
	 */
	public Department selectByPrimaryKey(Integer id) throws Exception;
	    
    /**
     * 根据查询条件来查询列表数据
     * @author monkey
     * @date 2016年6月3日 上午10:52:13
     * @param departmentQuery
     * @return
     * @throws Exception
     */
    public List<DepartmentCustom> selectList(DepartmentQuery departmentQuery)throws Exception;
    
    /**
     * 根据条件查询记录数
     * @author monkey
     * @date 2016年6月3日 上午10:54:09
     * @param departmentQuery
     * @return
     * @throws Exception
     */
    public int selectListCount(DepartmentQuery departmentQuery)throws Exception;
    
    /**
     * 根据名称查询单个实体
     * @author monkey
     * @date 2016年6月3日 上午10:54:27
     * @param name
     * @return
     * @throws Exception
     */
    public Department selectByName(String name)throws Exception;
    
    /**
     * 根据父节点获取子节点列表
     * @author monkey
     * @date 2016年6月4日 上午11:49:38
     * @param pid
     * @return
     * @throws Exception
     */
    public List<DepartmentCustom> findListByPid(Integer pid)throws Exception;
    
    /**
     * 根据主键删除数据
     * @author monkey
     * @date 2016年6月7日 上午10:58:17
     * @param id 主键
     * @return
     * @throws Exception
     */
    public int deleteByPrimaryKey(Integer id)throws Exception;
    
    /**
     * 根据父节点id获取子节点的个数
     * @author monkey
     * @date 2016年6月7日 下午3:06:40
     * @param pid
     * @return
     * @throws Exception
     */
    public int selectChildrenCount(Integer pid)throws Exception;

 

}
