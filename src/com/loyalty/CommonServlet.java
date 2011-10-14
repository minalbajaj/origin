package com.loyalty;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.loyalty.utils.SessionUtils;

public class CommonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CommonServlet() {
		super();
	}
	
	
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		doPost(request, response);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher;
		SessionFactory factory = SessionUtils.getSessionFactory();
		Session session = factory.openSession();
		Transaction tr;
		Query strQuery = null;
		HttpSession session1 = request.getSession();
		Date dtToday = new Date();
		try {
			if (request.getParameter("Pagename") != null && request.getParameter("Pagename").equals("login")) {
				String clientUser = request.getParameter("us");
				String clientPass = request.getParameter("ps");
				boolean flag = true;
				Query qlogin = null;
				qlogin = session.createQuery("select u.pk_user_id ,u.username, u.password,user_type from User u where u.username='"+ clientUser + "'");
				
				List login = qlogin.list();
				if (login.size() > 0) {
					Iterator itlogin = login.iterator();
					Object rowData[] = null;
					while (itlogin.hasNext()) {
						rowData = (Object[]) itlogin.next();
						if (rowData[2].equals(clientPass)) {
							session1.setAttribute("myname", clientUser);
							session1.setAttribute("mystatus", "Loggedin");
							session1.setAttribute("mytype", rowData[3].toString());
							session1.setAttribute("myid", rowData[0]);
							session1.setAttribute("mypwd", rowData[2]);
						} else {
							flag = false;
						}
					}
				} else {
					flag = false;
				}
				if (flag == false) 
				{
					request.setAttribute("IU", "iu");
					RequestDispatcher dispatcher1 = getServletContext().getRequestDispatcher("/Login.jsp");
					dispatcher1.forward(request, response);
					
					
				} else {
					RequestDispatcher dispatcher1 = getServletContext().getRequestDispatcher("/addUser.jsp");
					dispatcher1.forward(request, response);
				}
			} else if (request.getParameter("myname") != null && request.getParameter("myname").equals("AddUser")) {
				if (request.getParameter("user_name") != null) {
					tr = session.beginTransaction();
					String name = request.getParameter("user_name");
					String radio1 = request.getParameter("usertype");
					String pass = request.getParameter("user_pass");
					Query q5 = session.createQuery("Select u.pk_user_id ,u.username, u.password from User u where u.username='"+ name + "'");
					List userlistrd = q5.list();
					Iterator itlogin1 = userlistrd.iterator();
					if (userlistrd != null && userlistrd.size() > 0) {
						request.setAttribute("userlistrd", userlistrd);
					} else {
						User users = new User();
					    users.setUsername(name);
						users.setPassword(pass);
						
						users.setUser_update_date(dtToday);
						int intTrnUserID = Integer.parseInt(session1.getAttribute("myid").toString());
						users.setUpdate_user_id(intTrnUserID);
						users.setUser_type(radio1);
						session.save(users);
						request.setAttribute("result", "DONE");
						tr.commit();
					}
				}
				dispatcher = getServletContext().getRequestDispatcher("/addUser.jsp");
				dispatcher.forward(request, response);
			} else if (request.getParameter("userid1") != null|| (request.getParameter("myname") != null && request.getParameter("myname").equals("UpdateUser"))) {
				System.out.println("update1");
				int a1 = 0;
				if (request.getParameterValues("userid1") != null) {
					a1 = Integer.parseInt(request.getParameter("userid1"));
				}
				tr = session.beginTransaction();
				if (request.getParameter("hdnupdtuser") != null && request.getParameter("hdnupdtuser").equals("SubmitFormuser")) {
					String name1 = request.getParameter("txtuser_name");
					String pass1 = request.getParameter("user_pass");
					User user1 = (User) session.get(User.class, a1);
					user1.setUsername(name1);
					user1.setPassword(pass1);

					user1.setUser_update_date(dtToday);
					int intTrnUserID = Integer.parseInt(session1.getAttribute("myid").toString());
					user1.setUpdate_user_id(intTrnUserID);
					session.update(user1);
					request.setAttribute("result", "DONE");
				}
				System.out.println("update");
				Query q5 = session.createQuery("Select u.pk_user_id ,u.username from User u where u.user_type='U'");
				System.out.println(q5);
				List userlist1 = q5.list();
				request.setAttribute("updatelist1", userlist1);
				String r2 = null;
				if (request.getParameter("username1") != null && (request.getParameter("hdnupdtuser") == null || !request.getParameter("hdnupdtuser").equals("SubmitFormuser"))) {
					r2 = request.getParameter("username1");
					request.setAttribute("struserid", r2);
					Query q6 = session.createQuery("Select u.pk_user_id,u.username,u.password from User u where u.pk_user_id="+ r2);
					List userlist2 = q6.list();
					request.setAttribute("updatelist2", userlist2);
				}
				tr.commit();
  		    	RequestDispatcher dispatcher1 = getServletContext().getRequestDispatcher("/updateUser.jsp");
				dispatcher1.forward(request, response);
			} else if (request.getParameterValues("on") != null || (request.getParameter("myname") != null && request.getParameter("myname").equals("DeleteUser"))) {
				String Check[] = null;
				Integer si = 0;
				if (request.getParameterValues("on") != null) {
					Check = request.getParameterValues("on");
				}
				if (Check != null) {
					for (int i = 0; i < Check.length; i++) {
						si = Integer.valueOf(Check[i]);
						User u = (User) session.get(User.class, si);
						session.delete(u);
						request.setAttribute("result", si);
					}
				}
				tr = session.beginTransaction();
				Query qqq = session.createQuery("Select u.pk_user_id ,u.username from User u where u.user_type='U'");
				strQuery = session.createQuery("select count(u.pk_user_id),u.username from User u where u.user_type='U'");
				int istart = 0;
				int iPageNo = 0;
				int cPageNo = 1;
				int itotalpages = 0;
				int ilength = 10;
				List ltry = strQuery.list();
				Iterator ittry = ltry.iterator();
				double d = 0;
				String str = null;
				Object rowData1[] = null;
				while (ittry.hasNext()) {
					rowData1 = (Object[]) ittry.next();
					str = rowData1[0].toString();
					d = Double.valueOf(str).doubleValue();
					itotalpages = ((int) (Math.ceil((double) d / ilength)));
				}
				if (request.getParameter("iPageNo") != null) {
					cPageNo = Integer.parseInt(request.getParameter("iPageNo"));
					if (cPageNo == 0) {
						cPageNo = 1;
					} else if (cPageNo > itotalpages) {
						cPageNo = itotalpages;
					}
					istart = (cPageNo - 1) * ilength;
					iPageNo = cPageNo * ilength;
					qqq.setFirstResult(istart);
					qqq.setMaxResults(ilength);
				} else {
					qqq.setFirstResult(istart);
					qqq.setMaxResults(ilength);
				}
				List l13 = qqq.list();
				request.setAttribute("abc", l13);
				request.setAttribute("itotalpages", itotalpages);
				request.setAttribute("cPageNo", cPageNo);
				request.setAttribute("iPageNo", iPageNo);
				request.setAttribute("ilength", ilength);
				request.setAttribute("str", str);
				tr.commit();
				dispatcher = getServletContext().getRequestDispatcher("/deleteUser.jsp");
				dispatcher.forward(request, response);
			}
	// Change Password
			else if ((request.getParameter("myname") != null && request.getParameter("myname").equals("changepassword"))) {
                int a1 = 0;
				tr = session.beginTransaction();
				if (session1.getAttribute("myid") != null) {
					a1 = Integer.parseInt(session1.getAttribute("myid")
							.toString());
					String userpass = request.getParameter("cnfmpass");
					User user1 = (User) session.get(User.class, a1);
					user1.setPassword(userpass);
					session.update(user1);
					session1.setAttribute("mypwd", userpass);
					request.setAttribute("result", "DONE");
				}
				tr.commit();
				RequestDispatcher dispatcher1 = getServletContext().getRequestDispatcher("/changePassword.jsp");
				dispatcher1.forward(request, response);
			}
			// FOR CUSTOMER
			else if (request.getParameter("myname") != null && request.getParameter("myname").equals("Addcustomer")) {
				tr = session.beginTransaction();
				System.out.println("add");
				if (request.getParameter("member_code") != null) {
					System.out.println("add1");
					String member_code = request.getParameter("member_code");
					String member_title = request.getParameter("member_title");
					String first_name = request.getParameter("first_name");
					String last_name = request.getParameter("last_name");
					String member_address = request.getParameter("member_address");
					String member_city = request.getParameter("member_city");
					String member_state = request.getParameter("member_state");
					String member_pin = request.getParameter("member_pin");
					String member_email = request.getParameter("member_email");
					String member_phone = request.getParameter("member_phone");
					String member_mobile = request.getParameter("member_mobile");
					String member_gender = request.getParameter("member_gender");
					String member_status = request.getParameter("member_status");
					String spouse_first_name = request.getParameter("spouse_first_name");
					String spouse_last_name = request.getParameter("spouse_last_name");
					String spouse_email = request.getParameter("spouse_email");
					Member member=new Member();
					member.setMemberCode(member_code);
					member.setTitle(member_title);
					member.setFirstName(first_name);
					member.setLastName(last_name);
					member.setAddress(member_address);
					member.setCity(member_city);
					member.setState(member_state);
					member.setPin(member_pin);
					member.setPhone(member_phone);
					member.setMobile(member_mobile);
					member.setEmail(member_email);
					member.setGender(member_gender);
					member.setMaritalStatus(member_status);
					member.setSpouseFname(spouse_first_name);
					member.setSpouseLname(spouse_last_name);
					member.setSpouseEmail(spouse_email);
					DateFormat formatter;
					Date date1,date2,date3,date4;
					System.out.println("add1");
					formatter = new SimpleDateFormat("y/M/d");
					date1 = (Date) formatter.parse(request.getParameter("member_anniversary"));
				    member.setAnnivDate(date1);
					date2 = (Date) formatter.parse(request.getParameter("member_birthdate"));
					member.setBirthDate(date2);
				
					if(request.getParameter("spouse_birth_date")!=null && request.getParameter("spouse_birth_date")!=""){
					date3 = (Date) formatter.parse(request.getParameter("spouse_birth_date"));
					member.setSpouseBdate(date3);
					}
					else
					{  
						member.setSpouseBdate(null);
					}
					System.out.println("abv");
					Set mdetails = new HashSet();
					if(request.getParameter("frstrwfullname")!=null && request.getParameter("frstrwfullname")!=""){
					String frstrwfullname = request.getParameter("frstrwfullname");
					int frstrwage = Integer.parseInt(request.getParameter("frstrwage"));
					String frstrwrelation = request.getParameter("frstrwrelation");
					String frstrwgender = request.getParameter("frstrwgender");
			    	date4 = (Date) formatter.parse(request.getParameter("frstrwdate"));
					mdetails.add(new Memberfamily(frstrwage,frstrwrelation,frstrwgender,frstrwfullname,date4));
					}
				if(request.getParameter("secondrwfullname")!=null && request.getParameter("secondrwfullname")!=""){
					System.out.println("add5");
					String secondrwfullname = request.getParameter("secondrwfullname");
					int secondrwage = Integer.parseInt(request.getParameter("secondrwage"));
					String secondrwrelation = request.getParameter("secondrwrelation");
					String secondrwgender = request.getParameter("secondrwgender");
			    	date4 = (Date) formatter.parse(request.getParameter("secondrwdate"));
			    	mdetails.add(new Memberfamily(secondrwage,secondrwrelation,secondrwgender,secondrwfullname,date4));
				}
				if(request.getParameter("thirdrwfullname")!=null && request.getParameter("thirdrwfullname")!=""){
					System.out.println("add5");
					String thirdrwfullname = request.getParameter("thirdrwfullname");
					int thirdrwage = Integer.parseInt(request.getParameter("thirdrwage"));
					String thirdrwrelation = request.getParameter("thirdrwrelation");
					String thirdrwgender = request.getParameter("thirdrwgender");
			    	date4 = (Date) formatter.parse(request.getParameter("thirdtrwdate"));
			    	mdetails.add(new Memberfamily(thirdrwage,thirdrwrelation,thirdrwgender,thirdrwfullname,date4));
				}
				if(request.getParameter("forthrwfullname")!=null && request.getParameter("forthrwfullname")!=""){
					System.out.println("add5");
					String forthrwfullname = request.getParameter("forthrwfullname");
					int forthrwage = Integer.parseInt(request.getParameter("forthrwage"));
					String forthrwrelation = request.getParameter("forthrwrelation");
					String forthrwgender = request.getParameter("forthrwgender");
			    	date4 = (Date) formatter.parse(request.getParameter("forthrwdate"));
			    	mdetails.add(new Memberfamily(forthrwage,forthrwrelation,forthrwgender,forthrwfullname,date4));
				}
				System.out.println("out");
					member.setMdetails(mdetails);
					System.out.println("add8");
					session.save(member);
					request.setAttribute("result", "DONE");
					tr.commit();
				}
				dispatcher = getServletContext().getRequestDispatcher("/addMember.jsp");
				dispatcher.forward(request, response);
			} else if (request.getParameter("memberid1") != null || (request.getParameter("myname") != null && request.getParameter("myname").equals("Updatecustomer"))) {
				System.out.println("sdfsewf");
				int a2 = 0;
				if (request.getParameterValues("memberid2") != null) {
					a2 = Integer.parseInt(request.getParameter("memberid2"));
					System.out.println("id:"+a2);
				}
				tr = session.beginTransaction();
				if (request.getParameter("hdnupdt") != null && request.getParameter("hdnupdt").equals("SubmitFormupdt")) {
					String member_code = request.getParameter("member_code");
					String member_title = request.getParameter("member_title");
					String first_name = request.getParameter("first_name");
					String last_name = request.getParameter("last_name");
					String member_address = request.getParameter("member_address");
					String member_city = request.getParameter("member_city");
					String member_state = request.getParameter("member_state");
					String member_pin = request.getParameter("member_pin");
					String member_email = request.getParameter("member_email");
					String member_phone = request.getParameter("member_phone");
					String member_mobile = request.getParameter("member_mobile");
					String member_gender = request.getParameter("member_gender");
					String member_status = request.getParameter("member_status");
					String spouse_first_name = request.getParameter("spouse_first_name");
					String spouse_last_name = request.getParameter("spouse_last_name");
					String spouse_email = request.getParameter("spouse_email");
					Member memberupdate = (Member) session.get(Member.class,a2);
					memberupdate.setMemberCode(member_code);
					memberupdate.setTitle(member_title);
					memberupdate.setFirstName(first_name);
					memberupdate.setLastName(last_name);
					memberupdate.setAddress(member_address);
					memberupdate.setCity(member_city);
					memberupdate.setState(member_state);
					memberupdate.setPin(member_pin);
					memberupdate.setPhone(member_phone);
					memberupdate.setMobile(member_mobile);
					memberupdate.setEmail(member_email);
					memberupdate.setGender(member_gender);
					memberupdate.setMaritalStatus(member_status);
					memberupdate.setSpouseFname(spouse_first_name);
					memberupdate.setSpouseLname(spouse_last_name);
					memberupdate.setSpouseEmail(spouse_email);
					DateFormat formatter;
					Date date1,date2,date3,date4;
					formatter = new SimpleDateFormat("y/M/d");
				//	date1 = (Date) formatter.parse(request.getParameter("member_anniversary"));
				//	memberupdate.setAnnivDate(date1);
				//	date2 = (Date) formatter.parse(request.getParameter("member_birthdate"));
				//	memberupdate.setBirthDate(date2);
				//	if(request.getParameter("spouse_birth_date")!=null && request.getParameter("spouse_birth_date")!=""){
				//	date3 = (Date) formatter.parse(request.getParameter("spouse_birth_date"));
				//	memberupdate.setSpouseBdate(date3);
				//	}
				//	else
				//	{  
				//		memberupdate.setSpouseBdate(null);
				//	}
					Set mdetails = new HashSet();
					if(request.getParameter("frstrwfullname")!=null && request.getParameter("frstrwfullname")!=""){
					String frstrwfullname = request.getParameter("frstrwfullname");
					int frstrwage = Integer.parseInt(request.getParameter("frstrwage"));
					String frstrwrelation = request.getParameter("frstrwrelation");
					String frstrwgender = request.getParameter("frstrwgender");
			    	date4 = (Date) formatter.parse(request.getParameter("frstrwdate"));
					mdetails.add(new Memberfamily(frstrwage,frstrwrelation,frstrwgender,frstrwfullname,date4));
					}
				if(request.getParameter("secondrwfullname")!=null && request.getParameter("secondrwfullname")!=""){
					String secondrwfullname = request.getParameter("secondrwfullname");
					int secondrwage = Integer.parseInt(request.getParameter("secondrwage"));
					String secondrwrelation = request.getParameter("secondrwrelation");
					String secondrwgender = request.getParameter("secondrwgender");
			    	date4 = (Date) formatter.parse(request.getParameter("secondrwdate"));
			    	mdetails.add(new Memberfamily(secondrwage,secondrwrelation,secondrwgender,secondrwfullname,date4));
				}
				if(request.getParameter("thirdrwfullname")!=null && request.getParameter("thirdrwfullname")!=""){
					String thirdrwfullname = request.getParameter("thirdrwfullname");
					int thirdrwage = Integer.parseInt(request.getParameter("thirdrwage"));
					String thirdrwrelation = request.getParameter("thirdrwrelation");
					String thirdrwgender = request.getParameter("thirdrwgender");
			    	date4 = (Date) formatter.parse(request.getParameter("thirdtrwdate"));
			    	mdetails.add(new Memberfamily(thirdrwage,thirdrwrelation,thirdrwgender,thirdrwfullname,date4));
				}
				if(request.getParameter("forthrwfullname")!=null && request.getParameter("forthrwfullname")!=""){
					String forthrwfullname = request.getParameter("forthrwfullname");
					int forthrwage = Integer.parseInt(request.getParameter("forthrwage"));
					String forthrwrelation = request.getParameter("forthrwrelation");
					String forthrwgender = request.getParameter("forthrwgender");
			    	date4 = (Date) formatter.parse(request.getParameter("forthrwdate"));
			    	mdetails.add(new Memberfamily(forthrwage,forthrwrelation,forthrwgender,forthrwfullname,date4));
				}
				memberupdate.setMdetails(mdetails);
					session.update(memberupdate);
					request.setAttribute("result", "DONE");
				}
			
				Query q = session.createQuery("Select m.memberId,m.memberCode,m.firstName,m.lastName from Member m");
				List Custlist1 = q.list();
				request.setAttribute("updatelist1", Custlist1);
				String r1,r2 = null;
				if ((request.getParameter("membercodeupd") != null || request.getParameter("membernameupd") != null) && (request.getParameter("hdnupdt") == null || !request.getParameter("hdnupdt").equals("SubmitFormupdt"))) {
					if (request.getParameterValues("membercodeupd") != null) {
						r1 = request.getParameter("membercodeupd");
						request.setAttribute("strcustid", r1);
					}else
					{
						r1 = request.getParameter("membernameupd");
						
					}
					System.out.println("sdfsewf1"+r1);
					r2 = request.getParameter("membernameupd");
					request.setAttribute("strcustid1", r2);
					Query q2 = session.createQuery("Select m.memberId,m.title,m.memberCode,m.firstName,m.lastName,m.address,m.city,m.state,m.pin,m.email,m.phone,m.mobile,m.gender,m.maritalStatus,m.birthDate,m.annivDate,m.spouseFname,m.spouseLname,m.spouseEmail,m.spouseBdate from Member m where  m.memberId="+ r1);
					List Custlist2 = q2.list();
					System.out.println("sdfsewf1"+q2);
					
					request.setAttribute("updatelist2", Custlist2);
					System.out.println("sdfsewf1"+Custlist2);
				    Query q3 = session.createQuery("Select mf.mFamilyId,mf.Relation,mf.Gender,mf.Name,mf.DOB,mf.Age from Memberfamily mf where mf.memberId="+ r1);
					List Custlist3 = q3.list();
					request.setAttribute("updatelist3", Custlist3);
				}
				tr.commit();
				RequestDispatcher dispatcher1 = getServletContext().getRequestDispatcher("/updateMember.jsp");
				dispatcher1.forward(request, response);
			} else if (request.getParameterValues("on1") != null || (request.getParameter("myname") != null && request.getParameter("myname").equals("Deletecustomer"))) {
				String Check1[] = null;
				Integer si1;
				tr = session.beginTransaction();
				if (request.getParameterValues("on1") != null) {
					Check1 = request.getParameterValues("on1");
				}
				if (Check1 != null) {
					for (int i = 0; i < Check1.length; i++) {
						si1 = Integer.valueOf(Check1[i]);
						Member memberdel = (Member) session.get(Member.class,si1);
						session.delete(memberdel);
						request.setAttribute("result", si1);
					}
				}
				Query q4 = session.createQuery("Select m.memberId,m.memberCode, m.firstName,m.lastName from Member m");
				strQuery = session.createQuery("select count(m.memberId),m.memberCode,m.firstName,m.lastName from Member m");
				int istart = 0;
				int iPageNo = 0;
				int cPageNo = 1;
				int itotalpages = 0;
				int ilength = 10;
				List ltry = strQuery.list();
				Iterator ittry = ltry.iterator();
				String str = null;
				double d = 0;
				Object rowData1[] = null;
				while (ittry.hasNext()) {
					rowData1 = (Object[]) ittry.next();
					str = rowData1[0].toString();
					d = Double.valueOf(str).doubleValue();
					itotalpages = ((int) (Math.ceil((double) d / ilength)));
				}
				if (request.getParameter("iPageNo") != null) {
					cPageNo = Integer.parseInt(request.getParameter("iPageNo"));
					if (cPageNo == 0) {
						cPageNo = 1;
					} else if (cPageNo > itotalpages) {
						cPageNo = itotalpages;
					}
					istart = (cPageNo - 1) * ilength;
					iPageNo = cPageNo * ilength;
					q4.setFirstResult(istart);
					q4.setMaxResults(ilength);
				} else {
					q4.setFirstResult(istart);
					q4.setMaxResults(ilength);
				}
				List lc = q4.list();
				request.setAttribute("Deletecus", lc);
				request.setAttribute("itotalpages", itotalpages);
				request.setAttribute("cPageNo", cPageNo);
				request.setAttribute("iPageNo", iPageNo);
				request.setAttribute("ilength", ilength);
				request.setAttribute("str", str);
				tr.commit();
				dispatcher = getServletContext().getRequestDispatcher("/deleteMember.jsp");
				dispatcher.forward(request, response);
			}
			else if (request.getParameter("myname") != null
					&& request.getParameter("myname").equals("searchpage")) {
				String strOptVal = null;
				int istart = 0;
				int iPageNo = 0, cPageNo = 1;
				double d = 0;
				Object rowData1[] = null;
				int itotalpages = 0, ilength = 10;
				String strTotalCnt = null;
				Query qcount = null, q25 = null;
				if (request.getParameter("hdnOptVal") != null
						&& request.getParameter("hdnOptVal") != "") {
					strOptVal = request.getParameter("hdnOptVal");
					if (strOptVal.equals("date")
							&& request.getParameter("txtfromdate") != null) {
						String serhdate1 = request.getParameter("txtfromdate");
						String serhdate2 = request.getParameter("txttodate");
						qcount = session
								.createQuery("Select count(order_id),Cust_id,prod_Id,orderedqty,invoiceno,cust_name,Order_date,ProductName,ProductCost,customerorder,dispatching,dispatched,amount,AmendmentQty,AmendmentCost,AmendmentNo,AmendmentDate from datesearch where Order_date>= '"
										+ serhdate1
										+ "' and Order_date<='"
										+ serhdate2
										+ "' order by cust_name,customerorder");
						
						q25 = session
								.createQuery("Select order_id,Cust_id,prod_Id,orderedqty,invoiceno,cust_name,Order_date,ProductName,ProductCost,customerorder,dispatching,dispatched,amount,AmendmentQty,AmendmentCost,AmendmentNo,AmendmentDate from datesearch where Order_date>= '"
										+ serhdate1
										+ "' and Order_date<='"
										+ serhdate2
										+ "' order by cust_name,customerorder");
						request.setAttribute("serhdate1", serhdate1);
						request.setAttribute("serhdate2", serhdate2);
					} else if (strOptVal.equals("ordernumber")
							&& request.getParameter("entertext") != null) {
						String entertext = request.getParameter("entertext");
						qcount = session
								.createQuery("Select count(Order_id),srnoid,Cust_id,cust_Name,Order_date,Prod_ID,ProductName,ProductCost,orderedqty,invoiceno,customerorder,dispatched,dispatching,amount,AmendmentQty,AmendmentCost,AmendmentNo,AmendmentDate from orderSearch where customerorder like '"
										+ entertext + "%'order by cust_name,customerorder");
						q25 = session
								.createQuery("Select srnoid,Order_id,Cust_id,cust_Name,Order_date,Prod_ID,ProductName,ProductCost,orderedqty,invoiceno,customerorder,dispatched,dispatching,amount,AmendmentQty,AmendmentCost,AmendmentNo,AmendmentDate from orderSearch where customerorder like '"
										+ entertext + "%'order by cust_name,customerorder");
						request.setAttribute("entertext", entertext);
					} else if (strOptVal.equals("orderCustomerName")
							&& request.getParameter("entertext") != null
							&& !request.getParameter("entertext").equals("")) {
						String entertext = request.getParameter("entertext");
						qcount = session
								.createQuery("select count(Cust_id),srnoid,order_id,Cust_id,Order_date,ProductName,ProductCost,orderedqty,invoiceno,customerorder,dispatched,dispatching,amount,AmendmentQty,AmendmentCost,AmendmentNo,AmendmentDate from customerSearch c where c.cust_Name like '"
										+ entertext
										+ "%' order by cust_name,customerorder");
						q25 = session
								.createQuery("select srnoid,cust_Name ,order_id,Cust_id,Order_date,ProductName,ProductCost,orderedqty,invoiceno,customerorder,dispatched,dispatching,amount,AmendmentQty,AmendmentCost,AmendmentNo,AmendmentDate from customerSearch c where c.cust_Name like '"
										+ entertext
										+ "%' order by cust_name,customerorder");
						request.setAttribute("entertext", entertext);
					} else if (strOptVal.equals("orderProductName")
							&& request.getParameter("entertext") != null
							&& !request.getParameter("entertext").equals("")) {
						String entertext = request.getParameter("entertext");
						qcount = session
								.createQuery("select count(productid),productname,productcost,orderedqty,Order_id,invoiceno,cust_name,customerorder,dispatched,dispatching,amount,Order_date,AmendmentQty,AmendmentCost,AmendmentNo,AmendmentDate from searchProduct where  productname like '"
										+ entertext + "%'order by productname,cust_name,customerorder");
						q25 = session
								.createQuery("select productid,productname,productcost,orderedqty,Order_id,invoiceno,cust_name,customerorder,dispatched,dispatching,amount,Order_date,AmendmentQty,AmendmentCost,AmendmentNo,AmendmentDate from searchProduct where  productname like '"
										+ entertext + "%'order by productname,cust_name,customerorder");
						request.setAttribute("entertext", entertext);
					} else if (strOptVal.equals("invoicenumber")
							&& request.getParameter("entertext") != null
							&& !request.getParameter("entertext").equals("")) {
						String entertext = request.getParameter("entertext");
						qcount = session
								.createQuery("select count(invoiceNo),order_Id,totalAmount,dispatching,advance,netPayable,Cust_Name,customerorder,productname,productcost,amount,dispatched,orderedqty,AmendmentQty,AmendmentCost,AmendmentNo,AmendmentDate from invoiceSearch where invoiceNo ="
										+ entertext + " ");
						q25 = session
								.createQuery("select invoiceNo,order_Id,totalAmount,dispatching,advance,netPayable,Cust_Name,customerorder,productname,productcost,amount,dispatched,orderedqty,AmendmentQty,AmendmentCost,AmendmentNo,AmendmentDate from invoiceSearch  where invoiceNo ="
										+ entertext + " ");
						request.setAttribute("entertext", entertext);
					}
					if (qcount != null) {
						List ldate = qcount.list();
						//System.out.println( "size of ldate : " + ldate.size());
						Iterator ittry = ldate.iterator();
						while (ittry.hasNext()) {
							rowData1 = (Object[]) ittry.next();
							strTotalCnt = rowData1[0].toString();
							d = Double.valueOf(strTotalCnt).doubleValue();
							itotalpages = ((int) (Math.ceil((double) d
									/ ilength)));
						}
						if (request.getParameter("iPageNo") != null) {
							cPageNo = Integer.parseInt(request
									.getParameter("iPageNo"));
							if (cPageNo == 0) {
								cPageNo = 1;
							} else if (cPageNo > itotalpages) {
								cPageNo = itotalpages;
							}
							istart = (cPageNo - 1) * ilength;
							iPageNo = cPageNo * ilength;
							q25.setFirstResult(istart);
							q25.setMaxResults(ilength);
						}

						List <?> lstrsCount = qcount.list();
						request.setAttribute("lstrsCount", lstrsCount);
						List <?> lstrsResult = q25.list();
						request.setAttribute("lstrsResult", lstrsResult);
						request.setAttribute("itotalpages", itotalpages);
						request.setAttribute("cPageNo", cPageNo);
						request.setAttribute("iPageNo", iPageNo);
						request.setAttribute("ilength", ilength);
						request.setAttribute("strTotalCnt", strTotalCnt);
					}
					request.setAttribute("hdnOptVal", strOptVal);
				}

				if (request.getParameter("hdnInvoiceVal") != null
						&& request.getParameter("hdnInvoiceVal").equals(
								"Print invoice")
						&& strOptVal != null
						&& (strOptVal.equals("invoicenumber")
								|| strOptVal.equals("ordernumber") || strOptVal
								.equals("orderCustomerName"))
						&& request.getParameter("entertext") != null
						&& (request.getParameter("s_orderid2") != null
								|| request.getParameter("s_orderid") != null
								|| request.getParameter("s_invoiceno") != null
								|| request.getParameter("s_orderid2") != null || request
								.getParameter("s_invoiceno1") != null)
						&& !request.getParameter("entertext").equals("")) {
					dispatcher = getServletContext().getRequestDispatcher(
							"/Redirect.jsp");
					dispatcher.forward(request, response);
				} else {
					RequestDispatcher dispatcher1 = getServletContext()
							.getRequestDispatcher("/Search.jsp");
					dispatcher1.forward(request, response);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}