/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stdSessionController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

@Controller
//@SessionAttributes("uname")
public class LogoutController {

    @RequestMapping("/logout.html")
    public ModelAndView logout(SessionStatus status) {
        status.setComplete();
        ModelAndView mv = new ModelAndView("Logout");
        return mv;
    }
}
