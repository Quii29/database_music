# 🎼 DATA STORY: ĐIỀU GÌ LÀM NÊN MỘT NHẠC SĨ LỪNG DANH?

## (1) Câu chuyện

Âm nhạc, xét cho cùng, không chỉ là cảm xúc mà còn là dấu vết của thời gian và con người.

Có những nhạc sĩ miệt mài sáng tác, tích lũy hàng chục ca khúc – họ giống như những người thợ cần mẫn, kiên trì xây nên sự nghiệp bằng số lượng.  
Ngược lại, có những người không viết quá nhiều, nhưng mỗi tác phẩm đều được trình bày rộng rãi, lan tỏa qua nhiều giọng ca – đó là dấu hiệu của tài năng.

Một số nhạc sĩ chọn đi sâu vào một thể loại, đào đến tận cùng bản sắc – họ là những người theo đuổi chuyên môn.  
Trong khi đó, có người không ngừng dịch chuyển giữa nhiều phong cách, thử nghiệm và đổi mới – đó là những nhạc sĩ đa tài.

Nhưng khi thời gian trôi qua, chỉ một số ít được gọi là “lừng danh” – những người có nhiều ca khúc sống mãi, được dịch lại, được hát lại, và được nhớ đến.

Vậy câu hỏi đặt ra là:

> **Điều gì thực sự làm nên một nhạc sĩ lừng danh?**  
> Là sự cần mẫn hay tài năng?  
> Là chiều sâu chuyên môn hay sự đa dạng trong sáng tạo?

Dữ liệu có thể không cảm nhận được âm nhạc, nhưng có thể cho ta một câu trả lời khách quan.

---

## (2) Định nghĩa & câu hỏi truy vấn

### 2.1. Các khái niệm cơ bản

**Ca khúc để đời**  
- Có ≥ 3 bản dịch  
- Có ≥ 6 ca sĩ trình bày  

**Nhạc sĩ lừng danh**  
- Có ≥ 20% ca khúc là “để đời”

---

### 2.2. Phân loại nhạc sĩ

#### (A) Nhóm “Cần mẫn” vs “Tài năng”

**Nhạc sĩ cần mẫn**
- Có ≥ 10 ca khúc sáng tác  

**Nhạc sĩ tài năng**
- Có ≥ 2 ca khúc thuộc **top 25% ca khúc được trình bày nhiều nhất**
- Có ít nhất một thời kỳ đỉnh cao

📌 Truy vấn cần trả lời:
- Đếm số ca khúc theo nhạc sĩ  
- Tính số lượt trình bày của mỗi ca khúc  
- Xếp hạng ca khúc theo percentile (top 25%)  
- Xác định các ca khúc thuộc top 25%  
- Đếm số ca khúc top 25% theo từng nhạc sĩ  

---

#### (B) Nhóm “Chuyên môn” vs “Đa tài”

Sử dụng **Simpson Diversity Index**:

D = 1 - Σ(pᵢ²)

Trong đó:
- pᵢ là tỷ lệ ca khúc thuộc thể loại i

**Nhạc sĩ chuyên môn**
- D < 0.67  
- Có ít nhất 1 thể loại chiếm ≥ 67%

**Nhạc sĩ đa tài**
- D ≥ 0.67  
- Sáng tác ≥ 4 thể loại và không thể loại nào vượt quá 33% tổng sáng tác 

📌 Truy vấn cần trả lời:
- Đếm số ca khúc theo từng thể loại của mỗi nhạc sĩ  
- Tính tỷ lệ từng thể loại trên tổng số ca khúc  
- Tính tổng bình phương các tỷ lệ  
- Tính Simpson Index  
- Đếm số lượng thể loại mà mỗi nhạc sĩ sáng tác  

---

#### (C) Thời kỳ đỉnh cao

**Định nghĩa:**
- Một năm mà tổng (số lượt dịch + số lượt trình bày)  
  chiếm ≥ 36% toàn bộ sự nghiệp của nhạc sĩ  

📌 Truy vấn cần trả lời:
- Nhóm dữ liệu theo năm sáng tác  
- Tính tổng số lượt dịch và trình bày theo từng năm  
- Tính tổng toàn bộ sự nghiệp của nhạc sĩ  
- So sánh tỷ lệ từng năm với tổng sự nghiệp  

---

### 2.3. Xác định “nhạc sĩ lừng danh”

📌 Truy vấn:
- Xác định ca khúc để đời  
- Đếm số ca khúc để đời theo từng nhạc sĩ  
- Tính tỷ lệ ca khúc để đời trên tổng số ca khúc  
- Lọc các nhạc sĩ có tỷ lệ ≥ 20%  

---

## (3) Câu hỏi phân tích chính

### So sánh 1: Cần mẫn vs Tài năng
- Với mỗi nhóm:
  - Tổng số nhạc sĩ là bao nhiêu?
  - Có bao nhiêu nhạc sĩ lừng danh?
- Tính:
  - Tỷ lệ = (số nhạc sĩ lừng danh) / (tổng số nhạc sĩ trong nhóm)

---

### So sánh 2: Chuyên môn vs Đa tài
- Với mỗi nhóm:
  - Tổng số nhạc sĩ là bao nhiêu?
  - Có bao nhiêu nhạc sĩ lừng danh?
- Tính:
  - Tỷ lệ = (số nhạc sĩ lừng danh) / (tổng số nhạc sĩ trong nhóm)

---

## (4) Kết luận (Insight)

Từ dữ liệu, ta có thể rút ra:

- Nếu nhóm **tài năng** có tỷ lệ lừng danh cao hơn  
  → Sự lan tỏa của tác phẩm quan trọng hơn số lượng

- Nếu nhóm **cần mẫn** có tỷ lệ cao hơn  
  → Sự tích lũy lâu dài tạo ra xác suất thành công

- Nếu nhóm **đa tài** chiếm ưu thế  
  → Khả năng thích nghi và mở rộng thể loại giúp tăng ảnh hưởng

- Nếu nhóm **chuyên môn** chiếm ưu thế  
  → Chiều sâu trong một phong cách tạo nên dấu ấn mạnh mẽ

---

> **Kết luận cuối cùng:**  
> Dữ liệu không thay thế được cảm xúc, nhưng có thể chỉ ra một quy luật:  
> giữa số lượng và chất lượng, giữa chiều sâu và sự đa dạng —  
> con đường dẫn đến sự lừng danh luôn là sự cân bằng tinh tế giữa các yếu tố đó.
