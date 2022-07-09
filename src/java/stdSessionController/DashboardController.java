/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stdSessionController;

import org.springframework.stereotype.Controller;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.request;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.*;
@Controller
//@SessionAttributes("uname")
public class DashboardController {

    @RequestMapping(value = "/dashboard.html", method = RequestMethod.GET)
    public ModelAndView getAdmissionForm(HttpServletRequest request) {
//        HttpServletRequest name = (HttpServletRequest) request.getSession();
//        System.out.println("Session name = " + name);
        ModelAndView mv = new ModelAndView("Dashboard");
        return mv;
    }
}
