package academy.learnprogramming.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

@Slf4j
public class WebAppInitializer implements WebApplicationInitializer {

    private static final String DISPATCHER_SERVLET_NAME = "dispatcher";
    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        log.info("onStartup");

        // Create the spring application context
        AnnotationConfigWebApplicationContext context =
                new AnnotationConfigWebApplicationContext();

        context.register(WebConfig.class);

        // Create the dispatcher servlet
        DispatcherServlet dispatcherServlet =
                new DispatcherServlet(context);

        // Register and configure the dispatcher servlet
        ServletRegistration.Dynamic registration =
                servletContext.addServlet(DISPATCHER_SERVLET_NAME, dispatcherServlet);

        registration.setLoadOnStartup(1);
        registration.addMapping("/");


    }
}
