package com.tongyong.serviceImp;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tongyong.mapper.DepartmentMapper;
import com.tongyong.pojo.entity.addition.DepartmentCustom;
import com.tongyong.pojo.entity.addition.DepartmentQuery;
import com.tongyong.pojo.entity.Department;
import com.tongyong.process.context.MyConfig;
import com.tongyong.process.result.ResultUtil;
import com.tongyong.service.IDepartmentService;

/**
 * 部门-业务逻辑层接口-实现类
 * @author monkey
 * @date 2016年6月3日 上午11:08:03
 */
@Service
public class DepartmentServiceImpl implements IDepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Override
	public Department selectByPrimaryKey(Integer id) throws Exception {
		return departmentMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<DepartmentCustom> selectList(DepartmentQuery departmentQuery) throws Exception {
		return departmentMapper.selectList(departmentQuery);
	}

	@Override
	public int selectListCount(DepartmentQuery departmentQuery) throws Exception {
		return departmentMapper.selectListCount(departmentQuery);
	}

	@Override
	public Department selectByName(String name) throws Exception {
		return departmentMapper.selectByName(name);
	}

	@Override
	public int insert(Department record) throws Exception{
		//事务测试通过
//		int reuslt=departmentMapper.insert(record);
//		throw new CustomException(new ResultInfo(ResultInfo.TYPE_RESULT_FAIL,100,"测试事务异常"));
		
		record.setDataStatus(MyConfig.DATA_STATUS_YES);
		record.setCreateTime(new Date());
		record.setPrincipalId(0);//默认负责人id为0

		return departmentMapper.insert(record);
	}

	@Override
	public List<DepartmentCustom> findListByPid(Integer pid) throws Exception {
		return departmentMapper.findListByPid(pid);
	}

	@Override
	public int update(Department record) throws Exception {
		return departmentMapper.update(record);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) throws Exception {
		
		//判断它是否有子节点
		int childrenCount=this.selectChildrenCount(id);
		if(childrenCount>0){
			ResultUtil.throwCustomExcepion(202);
		}
		
		//判断该节点下是否有岗位
		
		return departmentMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int selectChildrenCount(Integer pid) throws Exception {
		return departmentMapper.selectChildrenCount(pid);
	}

}
