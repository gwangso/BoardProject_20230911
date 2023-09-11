package com.icia.board.repository;

import com.icia.board.dto.BoardDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardRepository {
    @Autowired
    private SqlSessionTemplate sql;
    public int save(BoardDTO boardDTO) {
        return sql.insert("Board.save", boardDTO);
    }

    public List<BoardDTO> findAll() {
        return sql.selectList("Board.findAll");
    }

    public BoardDTO findById(Long id) {
        BoardDTO boardDTO = sql.selectOne("Board.findById", id);
        return boardDTO;
    }

    public int updateHits(Long id) {
        int result = sql.update("Board.updateHits",id);
        return result;
    }

    public int update(BoardDTO boardDTO) {
        return sql.update("Board.update",boardDTO);
    }

    public int delete(Long id) {
        return sql.delete("Board.delete",id);
    }
}
