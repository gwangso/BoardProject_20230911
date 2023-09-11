package com.icia.board.service;

import com.icia.board.dto.BoardDTO;
import com.icia.board.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;

    public boolean save(BoardDTO boardDTO) {
        int result = boardRepository.save(boardDTO);
        if (result>0){
            return true;
        }else{
            return false;
        }
    }

    public List<BoardDTO> findAll() {
        return boardRepository.findAll();
    }

    public BoardDTO findById(Long id) {
        return boardRepository.findById(id);

    }

    public boolean updateHits(Long id) {
        int result = boardRepository.updateHits(id);
        if (result>0){
            return true;
        }else {
            return false;
        }
    }

    public boolean update(BoardDTO boardDTO) {
        int result = boardRepository.update(boardDTO);
        if (result>0){
            return true;
        }else {
            return false;
        }

    }

    public boolean delete(Long id) {
        int result = boardRepository.delete(id);
        if(result>0){
            return true;
        }else {
            return false;
        }
    }
}
