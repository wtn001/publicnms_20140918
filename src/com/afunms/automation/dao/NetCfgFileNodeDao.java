package com.afunms.automation.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.afunms.automation.model.NetCfgFileNode;
import com.afunms.common.base.BaseDao;
import com.afunms.common.base.BaseVo;
import com.afunms.common.base.DaoInterface;
import com.afunms.common.util.SysLogger;

public class NetCfgFileNodeDao extends BaseDao implements DaoInterface {

	public NetCfgFileNodeDao()
	{
		super("automation_node");
	}
	
	@Override
	public BaseVo loadFromRS(ResultSet rs) 
	{
	
		NetCfgFileNode vo = new NetCfgFileNode();
		 try
	      {
			  vo.setId(rs.getInt("id"));
	          vo.setIpaddress(rs.getString("ip_address"));
	          vo.setAlias(rs.getString("alias"));
	          vo.setUser(rs.getString("users"));
	          vo.setPassword(rs.getString("password"));
	          vo.setSuuser(rs.getString("suuser"));
	          vo.setSupassword(rs.getString("supassword"));
	          vo.setPort(rs.getInt("port"));
//	          vo.setDefaultpromtp(rs.getString("default_promtp"));
//	          vo.setEnablevpn(rs.getInt("enablevpn"));
//	          vo.setIsSynchronized(rs.getInt("is_synchronized"));
	          vo.setDeviceRender(rs.getString("device_render"));
	          vo.setOstype(rs.getString("ostype"));
	          vo.setConnecttype(rs.getInt("connecttype"));
	          //vo.setThreeA(rs.getString("three_a"));
	          //vo.setEncrypt(rs.getInt("encrypt"));
	          //System.out.println("NetCfgFileNodeDao-----");
	      }
	      catch(Exception e)
	      {
	          SysLogger.error("NetCfgFileNodeDao.loadFromRS()",e);
	          vo = null;
	      }
	      return vo;
	}
	public boolean isExistsIp(String ipAddresses)
	{
		int tmp = -1;
		String sql = "select count(*) from automation_node where ip_address in ('"+ipAddresses.replace(",", "','")+"')";
		rs = this.conn.executeQuery(sql);
		try{
			if(rs.next())
				tmp = rs.getInt(1);
		}catch(Exception e){
			
		}
		if(tmp>0)
			return true;
		else
			return false;
			
	}
	public int getMinId()
	{
		int id = -1;
		rs = this.conn.executeQuery("select min(id) from automation_node");
		try{
			if (rs.next())
				id = rs.getInt(1);
			return id;
		}catch(Exception e){
			return id;
		}
	}
	public int getNextId()
	{
		int id = 0;
		rs = this.conn.executeQuery("select max(id) from automation_node");
		try{
			if (rs.next())
				id = rs.getInt(1);
			return (id+1);
		}catch(Exception e){
			e.printStackTrace();
			return (id+1);
		}
	}
	public void deleteByIp(String ipAddress)
	{
		conn.executeUpdate("delete from automation_node where ip_address='"+ipAddress+"'");
	}
	public void executeUpdate(String sql)
	{
		conn.executeUpdate(sql);
	}
	 /** 
	    * 列出所有启动vpn的信息
	    */
	  public List loadAll()
	  {
	     List list = new ArrayList(5);
	     try
	     {
	         rs = conn.executeQuery("select * from automation_node order by id");
	         while(rs.next())
	        	list.add(loadFromRS(rs)); 
	     }
	     catch(Exception e)
	     {
	         SysLogger.error("NetCfgFileNodeDao:loadAll()",e);
	         list = null;
	     }
	     finally
	     {
	         conn.close();
	     }
	     return list;
	  }
	  public List loadEnableVpn()
	  {
	     List list = new ArrayList(5);
	     try
	     {
	         rs = conn.executeQuery("select * from automation_node where enablevpn=1 order by id");
	         while(rs.next())
	        	list.add(loadFromRS(rs)); 
	     }
	     catch(Exception e)
	     {
	         SysLogger.error("HaweitelnetconfDao:loadAll()",e);
	         list = null;
	     }
	     finally
	     {
	         conn.close();
	     }
	     return list;
	  }
	  public BaseVo loadByIp(String ip)
	  {
		  List list = new ArrayList(1);
		  String sql = "select * from automation_node where ip_address='"+ip+"'";
		  rs = conn.executeQuery(sql);
		  try{
			  while(rs.next())
				  list.add(loadFromRS(rs));
		  }catch(Exception e){e.printStackTrace();}
		  if(list.size()!=0)
			  return (BaseVo)list.get(0);
		  else
			  return null;
	  }
	  public List loadById(String id)
	  {
		  List list = new ArrayList(1);
		  String sql = "select * from automation_node where id="+id;
		  rs = conn.executeQuery(sql);
		  try{
			  while(rs.next())
				  list.add(loadFromRS(rs));
		  }catch(Exception e){
			  e.printStackTrace();
		   }
		 
		     
		     return list;
	  }
	  //ip组
	  public List loadByIps(String[] ipaddress) {
			List list = new ArrayList();
			StringBuffer sBuffer = new StringBuffer();
			for (int i = 0; i < ipaddress.length; i++) {
				sBuffer.append(ipaddress[i] + "','");
			}
			String ips = sBuffer.substring(0, sBuffer.length() - 2);
			StringBuffer sql = new StringBuffer();
			sql.append("select * from automation_node where ip_address in('" + ips
							+ ")");
			rs = conn.executeQuery(sql.toString());
			try {
				while (rs.next())
					list.add(loadFromRS(rs));
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println(sql.toString());
			return list;
		}
	  public List loadByIds(String[] ids)
	  {
		  String split = "";
		  for(int i=0;i<ids.length;i++)
		  {
			  split = ","+ids[i]+split;
		  }
		  List list = new ArrayList();
		  try{
			  StringBuffer sql = new StringBuffer();
			  sql.append("select * from automation_node where id in("+split.substring(1)+")");
			  rs = conn.executeQuery(sql.toString());
			  while(rs.next())
			  {
				  list.add(loadFromRS(rs));
			  }
		  }catch(Exception e){e.printStackTrace();}
		  return list;
	  }
	  
	  /** 
	    * 找到节点对应的
	    */
	  public String  findnodeip(int id)
	  {
	    String ipaddress="";
	     try
	     {
	         rs = conn.executeQuery("select * from topo_host_node where id="+id);
	         while(rs.next())
	         {
	        	 
	        	 ipaddress=rs.getString("ip_address");
	         }
	        	
	     }
	     catch(Exception e)
	     {
	         SysLogger.error("HaweitelnetconfDao:findnodeip()",e);
	         
	     }
	     finally
	     {
	        // conn.close();
	     }
	     return ipaddress;
	  }
	  
	  
	  
	    /**
	    * 修改方法
	    */
	  public boolean update(BaseVo baseVo) {
		  
		NetCfgFileNode vo = (NetCfgFileNode)baseVo;	 
		StringBuffer sql=new StringBuffer();
		sql.append("update automation_node set users ='");
		sql.append(vo.getUser());
		sql.append("',ip_address='");
		sql.append(vo.getIpaddress());
		sql.append("',suuser='");
		sql.append(vo.getSuuser());
		sql.append("',supassword='");
		sql.append(vo.getSupassword());
//		sql.append("',users='");
//		sql.append(vo.getUser());
		sql.append("',port='");
		sql.append(vo.getPort());
//		sql.append("',default_promtp='");
//		sql.append(vo.getDefaultpromtp());
		sql.append("',password='");
		sql.append(vo.getPassword());
//		sql.append("',enablevpn='");
//		sql.append(vo.getEnablevpn());
		sql.append("',ostype='");
		sql.append(vo.getOstype());
		sql.append("',device_render='");
		sql.append(vo.getDeviceRender());
		
		sql.append("',connecttype=");
		sql.append(vo.getConnecttype());
		sql.append(",alias='");
		sql.append(vo.getAlias());
		sql.append("' where id="+vo.getId());
		return saveOrUpdate(sql.toString());
	}
	   /**
	    * 添加方法
	    */
	   public boolean save(BaseVo basevo) {
		   NetCfgFileNode vo = (NetCfgFileNode)basevo;	  
		   StringBuffer sql = new StringBuffer();
		   sql.append("insert into automation_node(id,users,password,port,suuser,supassword,ip_address,device_render,ostype,connecttype,alias)values(");
		   sql.append(vo.getId());
		   sql.append(",'");
		   sql.append(vo.getUser());
		   sql.append("','");
		   sql.append(vo.getPassword());
		   sql.append("',");   
		   sql.append(vo.getPort());
		   sql.append(",'");
		   sql.append(vo.getSuuser());
		   sql.append("','");
		   sql.append(vo.getSupassword());
		   sql.append("','");
		   sql.append(vo.getIpaddress());
		   sql.append("','");
//		   sql.append(vo.getDefaultpromtp());
//		   sql.append("',");
//		   sql.append(vo.getEnablevpn());
//		   sql.append(",");
//		   sql.append(vo.getIsSynchronized());
//		   sql.append(",'");
		   sql.append(vo.getDeviceRender());
		   sql.append("','");
		   sql.append(vo.getOstype());
		   sql.append("',");
		   sql.append(vo.getConnecttype());
		   sql.append(",'");
		   sql.append(vo.getAlias());
		   sql.append("')");
		   return saveOrUpdate(sql.toString());
	}
	   public void addBatch(BaseVo basevo) {
			   NetCfgFileNode vo = (NetCfgFileNode)basevo;	  
			   StringBuffer sql = new StringBuffer();
			   
			   sql.append("insert into automation_node(id,users,password,port,suuser,supassword,ip_address,device_render,ostype,connecttype,alias)values(");
			   sql.append(vo.getId());
			   sql.append(",'");
			   sql.append(vo.getUser());
			   sql.append("','");
			   sql.append(vo.getPassword());
			   sql.append("',");
			   sql.append(vo.getPort());
			   sql.append(",'");
			   sql.append(vo.getSuuser());
			   sql.append("','");
			   sql.append(vo.getSupassword());
			   sql.append("','");
			   sql.append(vo.getIpaddress());
			   sql.append("','");
//			   sql.append(vo.getDefaultpromtp());
//			   sql.append("',");
//			   sql.append(vo.getEnablevpn());
//			   sql.append(",");
//			   sql.append(vo.getIsSynchronized());
//			   sql.append(",'");
			   sql.append(vo.getDeviceRender());
			   sql.append("','");
			   sql.append(vo.getOstype());
			   sql.append("',");
			   sql.append(vo.getConnecttype());
			   sql.append(",'");
			   sql.append(vo.getAlias());
			   sql.append("')");
			   this.conn.addBatch(sql.toString());
		}
	   	public void executeBatch()
	   	{
	   		try{
				conn.executeBatch();
				conn.commit();
			}catch(Exception e){
				e.printStackTrace();
			}
	   	}
		 /**
		  * 根据id删除这条记录
		  * @param id
		  * @return
		  */
		  public boolean delete(String id)
		   {
			   boolean result = false;
			   try
			   {
				   conn.addBatch("delete from automation_node where id=" + id);
				   conn.executeBatch();
				   result = true;
			   }
			   catch(Exception e)
			   {
				   SysLogger.error("NetCfgFileNodeDao.delete()",e); 
			   }
			   finally
			   {
				  // conn.close();
			   }
			   return result;
		   }
		  public List find(String ipaddress){
			  return findByCriteria("select * from automation_node k where k.ip_address like '%"+ipaddress+"%';");
		  }
		  
		  public String  findbyip(String ipaddress){
			  String id="";
			  try
			     {
			         rs = conn.executeQuery("select * from automation_node where ip_address='"+ipaddress+"';");
			         while(rs.next())
			         {
			        	 
			        	 id=rs.getString("id");
			         }
			        	
			     }
			     catch(Exception e)
			     {
			         SysLogger.error("HaweitelnetconfDao:findnodeip()",e);
			         
			     }
			     finally
			     {
			         conn.close();
			     }
			     return id;
		  }

    /**
     * 得到远程连接的配置文件列表
     * @return
     */
    public List getAllTelnetConfig(){
    	return findByCriteria("select * from automation_node");
    }
}
