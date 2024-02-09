public class AccountRecord implements Comparable {
    public Id Id { get; set; }
    public String Name { get; set; }
    public String Phone { get; set; }
    public String BillingStreet { get; set; }

    public AccountRecord(String name, String phone, String billingStreet) {
        this.Name = name;
        this.Phone = phone;
        this.BillingStreet = billingStreet;
    }

    public Id getId() {
        return Id;
    }

    public void setId(Id id) {
        this.Id = id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        this.Name = name;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String phone) {
        this.Phone = phone;
    }

    public String getBillingStreet() {
        return BillingStreet;
    }

    public void setBillingStreet(String billingStreet) {
        this.BillingStreet = billingStreet;
    }

    public Integer compareTo(Object compareTo) {
        AccountRecord otherAccount = (AccountRecord)compareTo;
        return this.Name.compareTo(otherAccount.Name);
    }
}