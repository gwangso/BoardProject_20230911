package com.icia.board.service;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.dto.PageDTO;
import com.icia.board.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;

    public void save(BoardDTO boardDTO) throws IOException {
        /*
            - 파일 있다.
                1. fileAttached=1, board_table에 저장 후 id값 받아오기
                2. 파일원본 이름 가져오기
                3. 저장용 이름 만들기
                4. 파일 저장용 폴더에 파일 저장 처리
                5. board_file_table에 관련 정보 저장
            - 파일 없다.
                fileAttached=0, 나머지는 기존과 같은 방식
         */
        BoardDTO savedBoard = null;
        if (boardDTO.getBoardFile().get(0).isEmpty()) { // 파일 없음
            boardRepository.save(boardDTO);
        } else { // 파일 있음
            boardDTO.setFileAttached(1);
            // 게시글 저장 후 id값 활용을 위해 리턴 받음
            savedBoard = boardRepository.save(boardDTO);
            // 파일이 여러게이기 때문에 반복문으로 파일 하나씩 꺼내서 저장 처리
            for(MultipartFile boardFile : boardDTO.getBoardFile()){
                // 파일만 따로 가져오기
                // MultipartFile boardFile = boardDTO.getBoardFile();
                // 파일이름 가져오기
                String originalFilename = boardFile.getOriginalFilename();;
                // 저장용 이름 만들기
                // System.out.println(System.currentTimeMillis()); // 1970년부터 지금까지 지난 초
                String storedFileName = System.currentTimeMillis() + "-" + originalFilename;
                BoardFileDTO boardFileDTO = new BoardFileDTO();
                boardFileDTO.setOriginalFileName(originalFilename);
                boardFileDTO.setStoredFileName(storedFileName);
                boardFileDTO.setBoardId(savedBoard.getId());

                // 파일 저장용 폴더에 파일 저장 처리
                String savePath = "D:\\spring_img\\" + storedFileName;
                boardFile.transferTo(new File(savePath));
                boardRepository.saveFile(boardFileDTO);
            }
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

    public void update(BoardDTO boardDTO) throws IOException{

        if (boardDTO.getBoardFile().get(0).isEmpty()){
            boardDTO.setFileAttached(0);
            boardRepository.update(boardDTO);
        }else {
            boardDTO.setFileAttached(1);
            boardRepository.update(boardDTO);
            for(MultipartFile boardFile : boardDTO.getBoardFile()){
                String originalFileName = boardFile.getOriginalFilename();
                String storedFileName = System.currentTimeMillis() + "-" +originalFileName;
                BoardFileDTO boardFileDTO = new BoardFileDTO();
                boardFileDTO.setOriginalFileName(originalFileName);
                boardFileDTO.setStoredFileName(storedFileName);
                boardFileDTO.setBoardId(boardDTO.getId());

                String savePath = "D:\\spring_img\\" + storedFileName;
                boardFile.transferTo(new File(savePath));
                boardRepository.saveFile(boardFileDTO);
            }
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


    public List<BoardFileDTO> findFile(Long boardId) {
        return boardRepository.findFile(boardId);
    }

    public List<BoardDTO> pagingList(int page) {
        int pageLimit = 3;
        int pagingStart = (page - 1) * pageLimit;
        Map<String, Integer> pagingParams = new HashMap<>();
        pagingParams.put("limit", pageLimit);
        pagingParams.put("start", pagingStart);
        return boardRepository.pagingList(pagingParams);
    }

    public PageDTO pageNumber(int page) {
        int pageLimit = 3; // 한페이지에 보여줄 글 갯수
        int blockLimit = 3; // 하단에 보여줄 페이지 번호 갯수
        // 전체 글 갯수 조회
        int boardCount = boardRepository.boardCount();
        // 전체 페이지 갯수 계산
        int maxPage = (int) (Math.ceil((double)boardCount / pageLimit));
        // 시작 페이지 값 계산(1, 4, 7, 10 ~~)
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        // 마지막 페이지 값 계산(3, 6, 9, 12 ~~)
        int endPage = startPage + blockLimit - 1;
        // 전체 페이지 갯수가 계산한 endPage 보다 작을 때는 endPage 값을 maxPage 값과 같게 세팅
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setStartPage(startPage);
        return pageDTO;
    }

    public List<BoardDTO> searchList(String query, String type, int page) {
        Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("query", query);
        searchParams.put("type", type);
        int pageLimit = 3;
        int pagingStart = (page - 1) * pageLimit;
        searchParams.put("limit", pageLimit);
        searchParams.put("start", pagingStart);

        return boardRepository.searchList(searchParams);
    }

    public PageDTO searchPageNumber(String query, String type, int page) {
        int pageLimit = 3; // 한페이지에 보여줄 글 갯수
        int blockLimit = 3; // 하단에 보여줄 페이지 번호 갯수
        Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("query", query);
        searchParams.put("type", type);
        // 전체 글 갯수 조회
        int boardCount = boardRepository.boardSearchCount(searchParams);
        // 전체 페이지 갯수 계산
        int maxPage = (int) (Math.ceil((double)boardCount / pageLimit));
        // 시작 페이지 값 계산(1, 4, 7, 10 ~~)
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        // 마지막 페이지 값 계산(3, 6, 9, 12 ~~)
        int endPage = startPage + blockLimit - 1;
        // 전체 페이지 갯수가 계산한 endPage 보다 작을 때는 endPage 값을 maxPage 값과 같게 세팅
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setStartPage(startPage);
        return pageDTO;
    }
}
