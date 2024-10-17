package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/inventory")
public class ChartViewController {
	@RequestMapping(value = "/chart", method = RequestMethod.GET)
	public String view() { 
		return "inventory/chart";
	}
}
