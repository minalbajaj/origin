package com.loyalty;

import java.util.Date;

public class Memberfamily {

	int mFamilyId,memberId,Age;
	String Relation,Gender,Name;
	Date DOB;
	public Memberfamily() {
		super();
	}
	
	
	public Memberfamily(int memberId, int age, String relation, String gender,
			String name, Date dOB) {
		super();
		this.memberId = memberId;
		Age = age;
		Relation = relation;
		Gender = gender;
		Name = name;
		DOB = dOB;
	}


	public Memberfamily(int age, String relation, String gender, String name,Date dOB) {
		super();
		Age = age;
		Relation = relation;
		Gender = gender;
		Name = name;
		DOB = dOB;
	}


	public int getmFamilyId() {
		return mFamilyId;
	}
	public void setmFamilyId(int mFamilyId) {
		this.mFamilyId = mFamilyId;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public int getAge() {
		return Age;
	}
	public void setAge(int age) {
		Age = age;
	}
	public String getRelation() {
		return Relation;
	}
	public void setRelation(String relation) {
		Relation = relation;
	}
	public String getGender() {
		return Gender;
	}
	public void setGender(String gender) {
		Gender = gender;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public Date getDOB() {
		return DOB;
	}
	public void setDOB(Date dOB) {
		DOB = dOB;
	}
	@Override
	public String toString() {
		return "Memberfamily [mFamilyId=" + mFamilyId + ", memberId="
				+ memberId + ", Age=" + Age + ", Relation=" + Relation
				+ ", Gender=" + Gender + ", Name=" + Name + ", DOB=" + DOB
				+ "]";
	}
	
	
}
