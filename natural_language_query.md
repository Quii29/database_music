**Q1:** Liệt kê mã tác giả và tên của các nhạc sĩ sáng tác ít nhất 8 bài hát sắp xếp theo bảng chữ cái -> Nhớm 2

**Q2.1** Liệt kê mã tác giả và tên của các nhạc sĩ có ít nhất 2 ca khúc thuộc top 25% ca khúc được trình bày nhiều nhất -> Nhóm 4

**Q2.2** Liệt kê mã tác giả, tên của các nhạc sĩ và số năm mà trong các năm đó, nhạc sĩ có tổng số lượt dịch và trình bày các ca khúc của mình chiếm ít nhất 36% toàn bộ sự nghiệp (số thời kỳ đỉnh cao) -> Nhóm 6

**Q2.3** Liệt kê mã tác giả, tên của các nhạc sĩ có ít nhất 2 ca khúc thuộc top 25% ca khúc được trình bày nhiều nhất và có không dưới một thời kỳ đỉnh cao -> Nhóm 3 

**Q3.1** Với khái niệm độ đa dạng được định nghĩa D = 1 - Σ(pᵢ²) với pᵢ là tỷ lệ ca khúc thuộc thể loại i, liệt kê mã tác giả, tên và độ đa dạng thể loại của các nhạc sĩ -> Nhóm 8 

**Q3.2** Liệt kê mã tác giả, tên của các nhạc sĩ, tên thể loại và tỉ lệ sáng tác của thể loại đó -> Nhóm 8

**Q3.3** Liệt kê mã tác giả, tên của các nhạc sĩ có ít nhất 1 thể loại chiếm không dưới 67% tổng sáng tác -> Nhóm 9

**Q3.4** Liệt kê mã tác giả, tên của các nhạc sĩ sáng tác ít nhất 4 thể loại -> Nhóm 9 

**Q3.5** Liệt kê mã tác giả, tên của các nhạc sĩ có ít nhất 1 thể loại chiếm không dưới 67% tổng sáng tác và có độ đa dạng thể loại dưới 0.67 -> Nhóm 3

**Q3.6** Liệt kê mã tác giả, tên của các nhạc sĩ có sáng tác ít nhất 4 thể loại và có điểm da dạng không dưới 0.67 -> Nhóm 3

**Q4** Liệt kê mã ca khúc, mã tác giả và tên của các ca khúc để đời -> Nhóm 4

**Q5** Liệt kê mã tác giả và tên của các nhạc sĩ lừng danh -> Nhóm 5

**Q6** Liệt kê mã tác giả, tên tác giả và thông tin phân loại: Cần mẫn, Tài năng, Chuyên môn, Đa dạng, Lừng danh (Đúng/Sai) 

Dưới đây là nội dung từ hình ảnh đã được chuyển sang định dạng Markdown:

1. Truy vấn đơn giản (`*`, `distinct`, `between`, `like`, ...)
  - Liệt kê mã và tên các ca khúc sáng tác vào trước năm 2000
  - Liệt kê mã và tên các ca khúc có chứa chữ "tình"
2. Truy vấn với mệnh đề `Order by`
  - Liệt kê mã tác giả, tên nhạc sĩ và số lượng ca khúc đã sáng tác sắp xếp từ cao đến thấp theo số ca khúc
  - Q1
3. Truy vấn với tập hợp (`Union`, `Intersect`, `Except`)
  - Q3.4
  - Q3.5
  - Q2.3 
4. Truy vấn với các loại phép kết: `Inner`, `Left`, `Right`, `Full/Union`
  - Q2.1
  - Q4
5. Truy vấn với so sánh tập hợp: `IN`, `EXIST`, `ANY`, `SOME`, `ALL`
  - Q5
  - Liệt kê tên các ca sĩ có hát ít nhất một bài hát của nhạc sĩ 'Trịnh Công Sơn'.
6. Truy vấn lồng: lồng tương quan & lồng phân cấp
  - Q2.2
  - Q6
7. Truy vấn với hàm kết hợp
  - Đếm số lượng ca khúc hiện có trong kho lưu trữ
  - Tìm ca khúc lâu đời nhất có trong kho lưu trữ 
8. Truy vấn với mệnh đề `Group by`
  - Q3.1
  - Q3.2 
9. Truy vấn với mệnh đề `Having`
  - Q3.3
  - Q3.4
10. Truy vấn với phép chia
  - Liệt kê tên các ca sĩ hát toàn bộ ca khúc của nhạc sĩ 'Trịnh Công Sơn'
  - Liệt kê tên bài hát mà không có nhạc sĩ nào trong kho lưu trữ chưa từng hát
11. Khác
  - Q6

**Flow:**

I. GÓC NHÌN TỔNG QUAN VỀ KHO CA KHÚC 

**Q1** Tìm ca khúc lâu đời nhất có trong kho lưu trữ 

**Q2** Liệt kê mã và tên các ca khúc sáng tác vào trước năm 2000

**Q3** Liệt kê mã và tên các ca khúc có chứa chữ "Love"

**Q4** Đếm số lượng ca khúc hiện có trong kho lưu trữ

**Q5** Liệt kê mã tác giả, tên nhạc sĩ và số lượng ca khúc đã sáng tác sắp xếp từ cao đến thấp theo số ca khúc

II. TÌM NHỮNG GƯƠNG MẶT CẦN MẪN

**Q6:** Liệt kê mã tác giả và tên của các nhạc sĩ sáng tác ít nhất 8 bài hát sắp xếp theo bảng chữ cái -> Nhớm 2

III. TÌM NHỮNG GƯƠNG MẶT TÀI NĂNG 

**Q7** Liệt kê mã tác giả và tên của các nhạc sĩ có ít nhất 2 ca khúc thuộc top 25% ca khúc được trình bày nhiều nhất -> Nhóm 4

**Q8** Liệt kê tên bài hát mà không có nhạc sĩ nào trong kho lưu trữ chưa từng hát

**Q9** Liệt kê mã tác giả, tên của các nhạc sĩ và số năm mà trong các năm đó, nhạc sĩ có tổng số lượt dịch và trình bày các ca khúc của mình chiếm ít nhất 36% toàn bộ sự nghiệp (số thời kỳ đỉnh cao) -> Nhóm 6

**Q10** Liệt kê mã tác giả, tên của các nhạc sĩ có ít nhất 2 ca khúc thuộc top 25% ca khúc được trình bày nhiều nhất và có không dưới một thời kỳ đỉnh cao -> Nhóm 3 

IV. XEM XÉT ĐỘ ĐA DẠNG THỂ LOẠI TRONG SÁNG TÁC 

**Q11** Với khái niệm độ đa dạng được định nghĩa D = 1 - Σ(pᵢ²) với pᵢ là tỷ lệ ca khúc thuộc thể loại i, liệt kê mã tác giả, tên và độ đa dạng thể loại của các nhạc sĩ -> Nhóm 8 

**Q12** Liệt kê mã tác giả, tên của các nhạc sĩ, tên thể loại và tỉ lệ sáng tác của thể loại đó -> Nhóm 8

**Q13** Liệt kê mã tác giả, tên của các nhạc sĩ có ít nhất 1 thể loại chiếm không dưới 67% tổng sáng tác -> Nhóm 9

**Q14** Liệt kê mã tác giả, tên của các nhạc sĩ sáng tác ít nhất 4 thể loại -> Nhóm 9 

**Q15** Liệt kê mã tác giả, tên của các nhạc sĩ có ít nhất 1 thể loại chiếm không dưới 67% tổng sáng tác và có độ đa dạng thể loại dưới 0.67 -> Nhóm 3

**Q16** Liệt kê mã tác giả, tên của các nhạc sĩ có sáng tác ít nhất 4 thể loại và có điểm da dạng không dưới 0.67 -> Nhóm 3

V. TÌM RA NHỮNG NHỮNG LỜI CA BẤT HỦ

**Q17** Liệt kê mã ca khúc, mã tác giả và tên của các ca khúc để đời -> Nhóm 4

**Q18** Liệt kê mã tác giả và tên của các nhạc sĩ lừng danh -> Nhóm 5

VI. YẾU TỐ NÀO ĐỂ THANH ÂM TRƯỜNG TỒN CÙNG NĂM THÁNG?

**Q19** Liệt kê mã tác giả, tên tác giả và thông tin phân loại: Cần mẫn, Tài năng, Chuyên môn, Đa dạng, Lừng danh (Đúng/Sai) 

VII. CHUYỆN BÊN LỀ: NGƯỜI GÓP LỜI - KẺ GÓP TIẾNG VÀ MỐI DUYÊN THỦY CHUNG 

**Q20** Liệt kê tên các ca sĩ có hát ít nhất một bài hát của nhạc sĩ Trịnh Công Sơn.

**Q21** Liệt kê tên các ca sĩ hát toàn bộ ca khúc của nhạc sĩ Trịnh Công Sơn.
