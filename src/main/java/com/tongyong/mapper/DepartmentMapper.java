package com.tongyong.mapper;

import java.util.List;

import com.tongyong.pojo.entity.addition.DepartmentCustom;
import com.tongyong.pojo.entity.addition.DepartmentQuery;
import com.tongyong.pojo.entity.Department;

/**
 * 部门-数据访问层接口
 * @author monkey
 * @date 2016年6月12日 上午11:52:45
 */
public interface DepartmentMapper {
	
	/**
	 * 新增一条数据
	 * @author monkey
	 * @date 2016年6月3日 上午11:11:21
	 * @param record
	 * @return
	 */
	int insert(Department record) ;
	
	/**
	 * 修改一条记录
	 * @author monkey
	 * @date 2016年6月7日 上午9:31:19
	 * @param record
	 * @return
	 * @
	 */
	int update(Department record);
	
	/**
	 * 根据id查询单条记录
	 * @author monkey
	 * @date 2016年6月3日 上午10:49:40
	 * @param id 主键
	 * @return 返回查询到的实体
	 * @
	 */
	public Department selectByPrimaryKey(Integer id) ;
	    
    /**
     * 根据查询条件来查询列表数据
     * @author monkey
     * @date 2016年6月3日 上午10:52:13
     * @param departmentQuery
     * @return
     * @
     */
    public List<DepartmentCustom> selectList(DepartmentQuery departmentQuery);
    
    /**
     * 根据条件查询记录数
     * @author monkey
     * @date 2016年6月3日 上午10:54:09
     * @param departmentQuery
     * @return
     * @
     */
    public int selectListCount(DepartmentQuery departmentQuery);
    
    /**
     * 根据名称查询单个实体
     * @author monkey
     * @date 2016年6月3日 上午10:54:27
     * @param name
     * @return
     * @
     */
    public Department selectByName(String name);
    
    /**
     * 根据父节点获取子节点列表
     * @author monkey
     * @date 2016年6月4日 上午11:49:38
     * @param pid
     * @return
     * @
     */
    public List<DepartmentCustom> findListByPid(Integer pid);
    
    /**
     * 根据主键删除数据
     * @author monkey
     * @date 2016年6月7日 上午10:58:17
     * @param id 主键
     * @return
     * @
     */
    public int deleteByPrimaryKey(Integer id);
    
    /**
     * 根据父节点id获取子节点的个数
     * @author monkey
     * @date 2016年6月7日 下午3:06:40
     * @param pid
     * @return
     * @
     */
    public int selectChildrenCount(Integer pid);

}