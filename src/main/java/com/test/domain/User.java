package com.test.domain;

public class User {
	/*
	 * 用户id,主键，唯一
	 */
    private Integer id;
    /*
     * 用户名
     */
    private String username;
    /*
     * 密码
     */
    private String password;
    /*
     * 邮箱
     */
    private String email;
    /*
     * 手机号
     */
    private String phone;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", email=" + email + ", phone="
				+ phone + "]";
	}
}