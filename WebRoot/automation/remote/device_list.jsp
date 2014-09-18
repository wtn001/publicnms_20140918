<%@page language="java" contentType="text/html;charset=GB2312"%>
<%@page import="java.util.Hashtable"%>
<%@page import="com.afunms.topology.model.ConnectTypeConfig"%>
<%@page import="java.util.*" %>
<%@page import="com.afunms.automation.model.PasswdTimingConfig"%>
<%@page import="com.afunms.automation.util.AutomationUtil"%>
<%@ include file="/automation/common/globe.inc"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.common.base.JspPage"%>
<%@page import="com.afunms.system.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String rootPath = request.getContextPath();
  String menuTable = (String)request.getAttribute("menuTable");
  List<PasswdTimingConfig> PasswdTimingBackupTelnetConfigList = (ArrayList<PasswdTimingConfig>)request.getAttribute("list");
  //List list = (List)request.getAttribute("passwdTimingBackupTelnetConfigList");
  System.out.println("device_list.jsp.....................start"+request.getAttribute("valTest"));
  JspPage jp = (JspPage) request.getAttribute("page");
 Hashtable<String,String> alarmWayHashtable=(Hashtable<String,String>)request.getAttribute("alarmWayHashtable");
  
%>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath() %>css/global/global.css" rel="stylesheet" type="text/css"/>
		<script language="JavaScript" type="text/javascript" src="<%=rootPath%>/automation/js/navbar.js"></script>
		<LINK href="<%=rootPath%>/automation/css/style.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=rootPath%>/automation/js/page.js"></script>
			
		<script language="JavaScript" type="text/JavaScript">
			var show = true;
			var hide = false;
			//�޸Ĳ˵������¼�ͷ����
			function my_on(head,body)
			{
				var tag_a;
				for(var i=0;i<head.childNodes.length;i++)
				{
					if (head.childNodes[i].nodeName=="A")
					{
						tag_a=head.childNodes[i];
						break;
					}
				}
				tag_a.className="on";
			}
			function my_off(head,body)
			{
				var tag_a;
				for(var i=0;i<head.childNodes.length;i++)
				{
					if (head.childNodes[i].nodeName=="A")
					{
						tag_a=head.childNodes[i];
						break;
					}
				}
				tag_a.className="off";
			}
			//���Ӳ˵�	
			function initmenu()
			{
				var idpattern=new RegExp("^menu");
				var menupattern=new RegExp("child$");
				var tds = document.getElementsByTagName("div");
				for(var i=0,j=tds.length;i<j;i++){
					var td = tds[i];
					if(idpattern.test(td.id)&&!menupattern.test(td.id)){					
						menu =new Menu(td.id,td.id+"child",'dtu','100',show,my_on,my_off);
						menu.init();		
					}
				}
			
			}
		</script>
		<script language="JavaScript">

			//��������
			var node="";
			var ipaddress="";
			var operate="";
			/**
			*���ݴ����id��ʾ�Ҽ��˵�
			*/
			function showMenu(id,nodeid,ip)
			{	
				ipaddress=ip;
				node=nodeid;
				//operate=oper;
			    if("" == id)
			    {
			        popMenu(itemMenu,100,"100");
			    }
			    else
			    {
			        popMenu(itemMenu,100,"1111");
			    }
			    event.returnValue=false;
			    event.cancelBubble=true;
			    return false;
			}
			/**
			*��ʾ�����˵�
			*menuDiv:�Ҽ��˵�������
			*width:����ʾ�Ŀ���
			*rowControlString:�п����ַ�����0��ʾ����ʾ��1��ʾ��ʾ���硰101�������ʾ��1��3����ʾ����2�в���ʾ
			*/
			function popMenu(menuDiv,width,rowControlString)
			{
			    //���������˵�
			    var pop=window.createPopup();
			    //���õ����˵�������
			    pop.document.body.innerHTML=menuDiv.innerHTML;
			    var rowObjs=pop.document.body.all[0].rows;
			    //��õ����˵�������
			    var rowCount=rowObjs.length;
			    //alert("rowCount==>"+rowCount+",rowControlString==>"+rowControlString);
			    //ѭ������ÿ�е�����
			    for(var i=0;i<rowObjs.length;i++)
			    {
			        //������ø��в���ʾ����������һ
			        var hide=rowControlString.charAt(i)!='1';
			        if(hide){
			            rowCount--;
			        }
			        //�����Ƿ���ʾ����
			        rowObjs[i].style.display=(hide)?"none":"";
			        //������껬�����ʱ��Ч��
			        rowObjs[i].cells[0].onmouseover=function()
			        {
			            this.style.background="#397DBD";
			            this.style.color="white";
			        }
			        //������껬������ʱ��Ч��
			        rowObjs[i].cells[0].onmouseout=function(){
			            this.style.background="#F1F1F1";
			            this.style.color="black";
			        }
			    }
			    //���β˵��Ĳ˵�
			    pop.document.oncontextmenu=function()
			    {
			            return false; 
			    }
			    //ѡ���Ҽ��˵���һ��󣬲˵�����
			    pop.document.onclick=function()
			    {
			        pop.hide();
			    }
			    //��ʾ�˵�
			    pop.show(event.clientX-1,event.clientY,width,rowCount*25,document.body);
			    return true;
			}
			
		</script>
		<script type="text/javascript">
		
			function edit()
			{
				mainForm.action="<%=rootPath%>/remoteDevice.do?action=ready_editPasswdTimingCfg&id="+node;
				mainForm.submit();
			}
	  		function addBackup()
			{
				mainForm.action="<%=rootPath%>/remoteDevice.do?action=addPasswdBackup&id="+node;
				mainForm.submit();
			}
	  		function disBackup()
			{
				mainForm.action="<%=rootPath%>/remoteDevice.do?action=disPasswdBackup&id="+node;
				mainForm.submit();
			}
			  			
			function toAdd(){
				mainForm.action = "<%=rootPath%>/remoteDevice.do?action=ready_addPasswd";
			    mainForm.submit();
			}
	  		function toDelete(){  
     				mainForm.action = "<%=rootPath%>/remoteDevice.do?action=deletePasswdTimingCfg";
     				mainForm.submit();
	  		}
			  
			
		</script>
	</head>
	<body id="body" class="body" onload="initmenu();">
	<div id="itemMenu" style="display: none";>
		<table border="1" width="100%" height="100%" bgcolor="#F1F1F1"
			style="border: thin;font-size: 12px" cellspacing="0">
			<tr>
				<td style="cursor: default; border: outset 1;" align="center"
					onclick="parent.edit()">�༭</td>
			</tr>
			<tr>
				<td style="cursor: default; border: outset 1;" align="center"
					onclick="parent.addBackup()">����</td>
			</tr>
			<tr>
				<td style="cursor: default; border: outset 1;" align="center"
					onclick="parent.disBackup()">ȡ������</td>
			</tr>
		</table>
	</div>
		<form id="mainForm" method="post" name="mainForm">
			<table id="body-container" class="body-container">
				<tr>
					<td class="td-container-main">
						<table id="container-main" class="container-main">
							<tr>
								<td class="td-container-main-content">
									<table id="container-main-content" class="container-main-content">
										<tr>
											<td>
												<table id="content-header" class="content-header">
								                	<tr>
									                	<td align="left" width="5"><img src="<%=rootPath%>/common/images/right_t_01.jpg" width="5" height="29" /></td>
									                	<td class="content-title"> �Զ��� >> Զ���豸ά�� >> ���붨ʱ��� </td>
									                    <td align="right"><img src="<%=rootPath%>/common/images/right_t_03.jpg" width="5" height="29" /></td>
									       			</tr>
									        	</table>
		        							</td>
		        						</tr>
		        						<tr>
		        							<td>
		        								<table id="content-body" class="content-body">
		        									<tr>
														<td>
															<table width="100%" cellpadding="0" cellspacing="1">
																<tr>
																	<td bgcolor="#ECECEC" width="10%" align='right'>
																		<a href="#" onclick="toAdd()">����</a>
																		<a href="#" onclick="toDelete()">ɾ��</a>&nbsp;&nbsp;&nbsp;
																	</td>
																</tr>
															</table>
														</td>
													</tr>
		        									<tr>
		        										<td colspan="2">
		        											<table cellspacing="0" border="1" bordercolor="#ababab">
		        												<tr height=28 style="background:#ECECEC" align="center" class="content-title">
		        													<td align="center"><INPUT type="checkbox" id="checkall" name="checkall" onclick="javascript:chkall()" class=noborder></td>
		        													<td align="center">���</td>
		        													<td align="center">IP��ַ</td>
		        												    <td align="center">���񴴽�ʱ��</td>

		        													<td align="center">��ʱ����ʱ��</td>
		        													<td align="center">���ѷ�ʽ</td>
		        													<td align="center">�Ƿ�ʱ</td>
		        													<td align="center" width="20%">����</td>
		        												</tr>
        												    <%					
															if(PasswdTimingBackupTelnetConfigList != null){
																//String[] frequencyName = { "ÿ��", "ÿ��", "ÿ��", "ÿ��", "ÿ��" };
																String[] monthCh = { " 1��", " 2��", " 3��", " 4��", " 5��", " 6��", " 7��", " 8��",
																		" 9��", " 10��", " 11��", " 12��" };
																String[] weekCh = { " ������", " ����һ", " ���ڶ�", " ������", " ������", " ������", " ������" };
																String[] dayCh = null;
																String[] hourCh =null;
																for(int i=0; i<PasswdTimingBackupTelnetConfigList.size(); i++){
																	PasswdTimingConfig passWDBackupTelnetConfig = (PasswdTimingConfig)PasswdTimingBackupTelnetConfigList.get(i);
																	StringBuffer sb = new StringBuffer();
																	String frequency = passWDBackupTelnetConfig.getBackup_sendfrequency();
																	String month = AutomationUtil.splitDate(passWDBackupTelnetConfig.getBackup_time_month(), monthCh, "month");
																	String week = AutomationUtil.splitDate(passWDBackupTelnetConfig.getBackup_time_week(), weekCh, "week"); 
																	String day = AutomationUtil.splitDate(passWDBackupTelnetConfig.getBackup_time_day(), dayCh, "day");
																	String hour = AutomationUtil.splitDate(passWDBackupTelnetConfig.getBackup_time_hou(), hourCh, "hour");
																	sb.append(frequency + " ");
														
																	if(frequency.equals("ÿ��")){//ÿ�� 
																		sb.append(" ʱ�䣺(" + hour + ")");
																	}
																	if(frequency.equals("ÿ��")){//ÿ��
																		sb.append(" ����:(" + week + ")");
																		sb.append(" ʱ�䣺(" + hour + ")");
																	}
																	if(frequency.equals("ÿ��")){//ÿ��
																		sb.append(" ���ڣ�(" + day + ")");
																		sb.append(" ʱ�䣺(" + hour + ")");
																	}
																	if(frequency.equals("ÿ��")){//ÿ��
																		sb.append(" �·ݣ�(" + month + ")");
																		sb.append(" ���ڣ�(" + day + ")");
																		sb.append(" ʱ�䣺(" + hour + ")");
																	}
																	if(frequency.equals("ÿ��")){//ÿ��
																		sb.append(" �·ݣ�(" + month + ")");
																		sb.append(" ���ڣ�(" + day + ")");
																		sb.append(" ʱ�䣺(" + hour + ")");
																	}
																	
																	String status = passWDBackupTelnetConfig.getStatus();
																	String wayId=passWDBackupTelnetConfig.getWarntype();
																	String wayName=alarmWayHashtable.get(wayId);
																 %>
		        												  <tr <%=onmouseoverstyle%>>
										        						<td align='center'>
																		<INPUT type="checkbox" class=noborder name="checkbox"
																				value="<%=passWDBackupTelnetConfig.getId()%>">
																		</td>
																		<td align='center'>
																			<font color='blue'><%=i+1 %></font>
		        														<br></td> 
		        														<td align='center'><%=passWDBackupTelnetConfig.getTelnetconfigips()%><br></td>
		        														<td align='center'><%=passWDBackupTelnetConfig.getBackup_date() %></td>
		        														<td align='center'><%=sb.toString()+"" %></td>
		        														<td align='center'><%=wayName %></td>
		        														<td align='center'><%="��".equals(status)?"����":"δ����" %></td>
		        														<td align='center'>
																			<img src="<%=rootPath%>/resource/image/status.gif" border="0" width=15 oncontextmenu=showMenu('2','<%=passWDBackupTelnetConfig.getId() %>') alt="�Ҽ�����">
																		</td>
		        													</tr>
		        													<%
		        												}}
	        												%>
		        												
		        											
		        											</table>
		        										</td>
		        									</tr>
		        								</table>
		        							</td>
		        						</tr>
		        						<tr>
		        							<td>
		        								<table id="content-footer" class="content-footer">
		        									<tr>
		        										<td>
		        											<table width="100%" border="0" cellspacing="0" cellpadding="0">
									                  			<tr>
									                    			<td align="left" valign="bottom"><img src="<%=rootPath%>/common/images/right_b_01.jpg" width="5" height="12" /></td>
									                    			<td></td>
									                    			<td align="right" valign="bottom"><img src="<%=rootPath%>/common/images/right_b_03.jpg" width="5" height="12" /></td>
									                  			</tr>
									              			</table>
		        										</td>
		        									</tr>
		        								</table>
		        							</td>
		        						</tr>
		        					</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>