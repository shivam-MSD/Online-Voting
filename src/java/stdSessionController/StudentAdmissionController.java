/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stdSessionController;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import javax.enterprise.inject.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.beans.*;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
//@SessionAttributes("uname")
public class StudentAdmissionController {

    @RequestMapping(value = "/admissionForm.html", method = RequestMethod.GET)
    public ModelAndView getAdmissionForm() {
        ModelAndView mv = new ModelAndView("AdmissionForm");
        mv.addObject("mainHeader", "Dharmsinh Desai University");
        return mv;
    }

    @RequestMapping(value = "/submitAdmissionForm.html", method = RequestMethod.POST)

//    public ModelAndView submitAdmissionForm(@RequestParam("studentName")String name,@RequestParam("studentContact")String mobn,)
    // set default value when value is not entered
//    public ModelAndView submitAdmissionForm(@RequestParam(value = "studentName",defaultValue="Unknown")String name,@RequestParam(value="studentContact",defaultValue="0")String mobno)
    // handle many form fields in request using *** Map ***handler method in a controller
//    public ModelAndView submitAdmissionForm(@RequestParam Map<String,String> stdDetails)
//    public ModelAndView submitAdmissionForm(@RequestParam("studentName") String name, @RequestParam("studentContact") String mobno) 
    public ModelAndView submitAdmissionForm(@ModelAttribute("student") Student stdObj, BindingResult result) {

        if (result.hasErrors()) {
            ModelAndView model = new ModelAndView("AdmissionForm");
            return model;
        }
        // when using Map

//                    String name,mobno;
//                    name = stdDetails.get("studentName");
//                    mobno = stdDetails.get("studentContact");
        // when using Map
        //Creating Student class
//            Student student = new Student();
//            student.setStudentName(name);
//            student.setStudentContact(mobno);
        //Creating Student class
        ModelAndView mv = new ModelAndView("AdmissionSuccess");
//        mv.addObject("msg", "Your Registration is successfully done by name:- " + name + "    And Contact No. :- " + mobno);

        // Accessing each data (filled form field) individually
        // Creating Student Class
        mv.addObject("mainHeader", "Dharmsinh Desai University");

        mv.addObject("headerMsg", "Your Registration is successfully done.");
//        mv.addObject("student", student);
        // Creating Student Class
        // Accessing each data (filled form field) individually

        // Using @ModelAttribute("student")Student stdObj
//        mv.addObject("student", stdObj);

        mv.addObject("uname", stdObj.getStudentName());

        return mv;
    }

//    @ModelAttribute
//    public void addingCommonObjects(Model model) {
//        model.addAttribute("mainHeader", "Dharmsinh Desai University");
//    }
}
