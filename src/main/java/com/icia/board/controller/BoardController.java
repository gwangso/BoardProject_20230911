package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.dto.CommentDTO;
import com.icia.board.dto.PageDTO;
import com.icia.board.service.BoardService;
import com.icia.board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private CommentService commentService;

    @GetMapping("/save")
    public String save(){
        return "board/boardSave";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute BoardDTO boardDTO) throws IOException {
            boardService.save(boardDTO);
        return "redirect:/board/list";
    }

    @GetMapping("/list")
    public String findAll(@RequestParam(value = "page", required = false, defaultValue = "1") int page, // required : 필수정보인가(true) 아닌가(false)
                          @RequestParam(value = "query", required = false, defaultValue = "") String query,
                          @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type,
                          Model model){
        List<BoardDTO> boardDTOList = null;
        PageDTO pageDTO = null;

        if(query.equals("")){
            // 일반 페이지 요청
            boardDTOList = boardService.pagingList(page);
            pageDTO = boardService.pageNumber(page);
        }else {
            // 검색결과 페이지 요청
            boardDTOList = boardService.searchList(query, type, page);
            pageDTO = boardService.searchPageNumber(query, type, page);
        }
        model.addAttribute("boardList", boardDTOList);
        model.addAttribute("paging", pageDTO);
        model.addAttribute("query", query);
        model.addAttribute("type", type);
        model.addAttribute("page", page);
        return "board/boardList";
    }

    @GetMapping
    public String findById(@RequestParam("id") Long id,
                           @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                           @RequestParam(value = "query", required = false, defaultValue = "") String query,
                           @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type,
                           Model model){
        BoardDTO boardDTO = boardService.findById(id);
        boardService.updateHits(id);
        model.addAttribute("board", boardDTO);
        if (boardDTO.getFileAttached() == 1){
            List<BoardFileDTO> boardFileDTOList = boardService.findFile(id);
            model.addAttribute("boardFileList", boardFileDTOList);
        }
        List<CommentDTO> commentDTOList = commentService.findAll(id);
        if (commentDTOList.size() == 0){
            model.addAttribute("commentList", null);
        }else {
            model.addAttribute("commentList", commentDTOList);
        }
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        model.addAttribute("type", type);
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
    public String delete(@RequestParam("id") Long id,
                         Model model){
        boolean result = boardService.delete(id);
        if (result){
            return "redirect:/board/list";
        }else {
            BoardDTO boardDTO = boardService.findById(id);
            model.addAttribute("board",boardDTO);
            return "/board/boardDetail";
        }
    }
}
