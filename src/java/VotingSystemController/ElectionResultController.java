/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package VotingSystemController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/Home")
public class ElectionResultController {

    @RequestMapping(value = "/result", method = RequestMethod.GET)
    public ModelAndView fillShowResultForm() {
        ModelAndView mv = new ModelAndView("ElectionResultSelectField");
        mv.addObject("electionresultheading", "Search Election Result");
        return mv;
    }

    @RequestMapping(value = "/result", method = RequestMethod.POST)
    public ModelAndView displayResult(@ModelAttribute("candidate") Candidate c) {
        String resulttype;
        String year = c.getYear();
        String position = c.getPosition();
        String state;
        String statearr = c.getState();
        String statearray[] = statearr.split(":");
        String city;
        String village;

        state = statearray[1];
        city = c.getCity();
        village = c.getVillage();
        if (year != null) {

//            if (position.equals("Mayor")) {
//                c.setPosition(position);
//                c.setState(state);
//                c.setCity(city);
//                c.setVillage(village);
//
//                ModelAndView mv = new ModelAndView("ElectionResultDisplay");
//                mv.addObject("candidate", c);
//                mv.addObject("electionresultheading", "Search Election Result");
//                return mv;
//
//            } else if (position.equals("MP")) {
//
//            } else if (position.equals("MLA")) {
//
//            } else {
//                village = c.getVillage();
//            }


                c.setPosition(position);
                c.setState(state);
                c.setCity(city);
                c.setVillage(village);

                ModelAndView mv = new ModelAndView("ElectionResultDisplay");
                mv.addObject("candidate", c);
                mv.addObject("electionresultheading", "Search Election Result");
                return mv;
//            ModelAndView mv = new ModelAndView("ElectionResultSelectField");
//            mv.addObject("error", "error1 = " + state + " " + city + " -> " + village + " - year = " + year + "position = " + position);
//            mv.addObject("electionresultheading", "Search Election Result");
//            return mv;
        } else {
            
            c.setPosition(position);
                c.setState(state);
                c.setCity(city);
                c.setVillage(village);

                ModelAndView mv = new ModelAndView("ElectionResultDisplay");
                mv.addObject("candidate", c);
                mv.addObject("electionresultheading", "Search Election Result");
                return mv;
                
//            ModelAndView mv = new ModelAndView("ElectionResultSelectField");
//            mv.addObject("error", "error1 = " + state + " " + city + " -> " + village + " - year = " + year);
//            mv.addObject("electionresultheading", "Search Election Result");
//            return mv;
        }

    }

}
