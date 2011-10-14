package com.loyalty;

import java.util.Date;
import java.util.Set;

public class Member {
    int memberId;
    String pin,phone,mobile,memberCode;
    String title,firstName,lastName,address,city,state,email,gender,maritalStatus,spouseFname,spouseLname,spouseEmail;
    Date birthDate,annivDate,spouseBdate;
    Set mdetails;
    
    
    public Member() {
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getAnnivDate() {
        return annivDate;
    }

    public void setAnnivDate(Date annivDate) {
        this.annivDate = annivDate;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }

    public Date getSpouseBdate() {
        return spouseBdate;
    }

    public void setSpouseBdate(Date spouseBdate) {
        this.spouseBdate = spouseBdate;
    }

    public String getSpouseEmail() {
        return spouseEmail;
    }

    public void setSpouseEmail(String spouseEmail) {
        this.spouseEmail = spouseEmail;
    }

    public String getSpouseFname() {
        return spouseFname;
    }

    public void setSpouseFname(String spouseFname) {
        this.spouseFname = spouseFname;
    }

    public String getSpouseLname() {
        return spouseLname;
    }

    public void setSpouseLname(String spouseLname) {
        this.spouseLname = spouseLname;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


	public Set getMdetails() {
		return mdetails;
	}

	public void setMdetails(Set mdetails) {
		this.mdetails = mdetails;
	}
	
	

	public String getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", pin=" + pin + ", phone="
				+ phone + ", mobile=" + mobile + ", memberCode=" + memberCode
				+ ", title=" + title + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", address=" + address + ", city="
				+ city + ", state=" + state + ", email=" + email + ", gender="
				+ gender + ", maritalStatus=" + maritalStatus
				+ ", spouseFname=" + spouseFname + ", spouseLname="
				+ spouseLname + ", spouseEmail=" + spouseEmail + ", birthDate="
				+ birthDate + ", annivDate=" + annivDate + ", spouseBdate="
				+ spouseBdate + ", mdetails=" + mdetails + "]";
	}

	


   
}
