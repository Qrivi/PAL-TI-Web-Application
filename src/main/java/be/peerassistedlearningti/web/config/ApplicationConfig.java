package be.peerassistedlearningti.web.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.lookup.JndiDataSourceLookup;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.JpaVendorAdapter;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.Database;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import javax.sql.DataSource;

@Configuration
@EnableJpaRepositories( "be.peerassistedlearningti" )
public class ApplicationConfig
{

    @Bean
    public DataSource dataSource()
    {
        JndiDataSourceLookup dsLookup = new JndiDataSourceLookup();
        dsLookup.setResourceRef( true );
        return dsLookup.getDataSource( "jdbc/PAL" );
    }

    @Bean
    public JpaTransactionManager transactionManager()
    {
        return new JpaTransactionManager( entityManagerFactory().getObject() );
    }

    @Bean
    public JpaVendorAdapter jpaVendorAdapter()
    {
        HibernateJpaVendorAdapter jpaVendorAdapter = new HibernateJpaVendorAdapter();
        jpaVendorAdapter.setDatabase( Database.MYSQL );
        return jpaVendorAdapter;
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactory()
    {
        LocalContainerEntityManagerFactoryBean factoryBean = new LocalContainerEntityManagerFactoryBean();
        factoryBean.setDataSource( dataSource() );
        factoryBean.setJpaVendorAdapter( jpaVendorAdapter() );
        factoryBean.setPackagesToScan( "be.peerassistedlearningti" );
        return factoryBean;
    }

}
