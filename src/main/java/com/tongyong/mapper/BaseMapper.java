package com.tongyong.mapper;

import java.util.List;

/**
 * 基mapper接口
 * @author monkey
 * @date 2016年6月14日 下午6:45:28
 * @param <T> 原始类
 * @param <Q> 查询条件类
 * @param <R> 查询结果类
 */
public interface BaseMapper<T,Q,R> {
	
    /**
     * 新增
     * @author monkey
     * @date 2016年6月14日 下午6:48:45
     * @param entity
     * @return
     * @throws Exception
     */
    public int insert(T entity);
    
    /**
     * 根据主键删除单条记录
     * @author monkey
     * @date 2016年6月14日 下午6:48:57
     * @param id
     * @return
     * @throws Exception
     */
    public int deleteByPrimaryKey(Integer id);

    /**
     * 修改
     * @author monkey
     * @date 2016年6月14日 下午6:49:18
     * @param entity
     * @return
     * @throws Exception
     */
    int update(T entity);
    
    /**
     * 根据主键查询单条记录
     * @author monkey
     * @date 2016年6月14日 下午6:49:31
     * @param id
     * @return
     * @throws Exception
     */
    public T selectByPrimaryKey(Integer id);

    /**
     * 根据查询条件，查询列表数据
     * @author monkey
     * @date 2016年6月14日 下午6:49:57
     * @param query
     * @return
     * @throws Exception
     */
    public List<R> selectList(Q query);
    
    /**
     * 根据查询条件，获得记录数
     * @author monkey
     * @date 2016年6月14日 下午6:50:19
     * @param query
     * @return
     * @throws Exception
     */
    public int selectListCount(Q query);
}
