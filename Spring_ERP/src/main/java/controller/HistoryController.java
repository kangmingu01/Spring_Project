package controller;

import java.util.Map;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import dto.History;
import lombok.RequiredArgsConstructor;
import service.HistoryService;

@RestController
@RequestMapping("/inventory")
@RequiredArgsConstructor
public class HistoryController {
	private final HistoryService historyService;
	
	@GetMapping("/history_list")
	public Map<String, Object> historyList(@RequestParam Map<String, Object> map){
		return historyService.getselectHistoryProductWarehouseList(map);
	}
	
	@GetMapping("/history_modify_view/{historyId}")
	public History inventoryModifyView(@PathVariable int historyId) {
		return historyService.selectHistoryUpdate(historyId);
	}
	
	@PostMapping("/history_add")
	public String addHistory(@RequestBody History history) {
		historyService.addHistory(history);
		return "success";
	}
	
	@PutMapping("/history_modify")
	public String modifyHistory(@RequestBody History history) {
		historyService.modifyHistory(history);
		return "success";
	}
	
	@DeleteMapping("/history_remove/{historyId}")
	public String removeHistory(@PathVariable int historyId) {
		historyService.removeHistory(historyId);
		return "success";
	};
	
	
}
