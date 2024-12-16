package com.poly.entity;



import java.util.Set;
import java.util.stream.Collectors;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.poly.util._enum.AuthTypeEnum;
import com.poly.util._enum.RoleUserEnum;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="Account")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AccountID")
    private int accountID;

    @Column(name="UserName", columnDefinition = "NVARCHAR(255)")
    private String userName;

    @Column(name="Password", columnDefinition = "NVARCHAR(255)")
    private String passWord;
    
    
    @OneToOne(mappedBy = "account")
    private Customer customer;
    
    @Builder.Default
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "user_role",
        joinColumns = {@JoinColumn(name = "user_id", referencedColumnName = "accountID")},
        inverseJoinColumns = {@JoinColumn(name = "role_id", referencedColumnName = "id")})
    private Set<Role> roles = Set.of(new Role(RoleUserEnum.USER));
    
    @Builder.Default
    @Enumerated(EnumType.ORDINAL)
    private AuthTypeEnum authType = AuthTypeEnum.LOCAL;
    
    @Builder.Default
    private String authId = null;
    public String getRoleString() {
      return this.roles.stream().map(r -> r.getName()).collect(Collectors.joining(", "));
    }
    
}
