package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;

    @GetMapping("/save")
    public String save(){
        return "board/boardSave";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute BoardDTO boardDTO) throws IOException {
            boardService.save(boardDTO);
        return "index";
    }

    @GetMapping("/")
    public String findAll(Model model){
        List<BoardDTO> boardDTOList = boardService.findAll();
        model.addAttribute("boardList", boardDTOList);
        return "board/boardList";
    }

    @GetMapping
    public String detail(@RequestParam("id") Long id,
                           Model model){
        BoardDTO boardDTO = boardService.findById(id);
        boardService.updateHits(id);
        model.addAttribute("board", boardDTO);
        if (boardDTO.getFileAttached() == 1){
            BoardFileDTO boardFileDTO = boardService.findFile(id);
            model.addAttribute("boardFile", boardFileDTO);
        }
        return "/board/boardDetail";
    }

    @GetMapping("/update")
    public String update(@RequestParam("id") Long id,
                         Model model){
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board",boardDTO);
        return "/board/boardUpdate";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO,
                         Model model){
        boolean result = boardService.update(boardDTO);
        if (result){
            BoardDTO dto = boardService.findById(boardDTO.getId());
            model.addAttribute("board",dto);
            return "/board/boardDetail";
        }else {
            return "redirect:/board/update?id="+boardDTO.getId();
        }
    }

    @GetMapping("/delete")
    public String deletePage(@RequestParam("id") Long id,
                         Model model){
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board",boardDTO);
        return "/board/deleteCheck";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Long id,
                         Model model){
        boolean result = boardService.delete(id);
        if (result){
            return "redirect:/board/";
        }else {
            BoardDTO boardDTO = boardService.findById(id);
            model.addAttribute("board",boardDTO);
            return "/board/boardDetail";
        }
    }
}
