# Fraud Analysis

English
---
Project Overview

This project was created to analyze customer reports related to “Delivered but Not Received”, a condition where customers report that a package is marked as delivered, but the item was not actually received.

The dataset represents an internal investigation process typically handled by the operations team, especially checks related to:
- Proof of delivery (POD),
- Potential system issues,
- Indications of courier fraud.

The data used is dummy data, designed based on real operational workflows commonly applied when investigating problematic deliveries (fake POD cases). The data structure, investigation flow, and categorization are intentionally modeled to reflect real-world conditions.

Tools Used
1. Excel – data cleaning & preparation
2. SQL – data aggregation & analysis
3. Power BI – visualization & dashboard

NOTE: This dataset was created for learning and portfolio purposes, with a structure adapted from real operational and delivery investigation experience.

Excel: Data Preparation
---
Before analysis, the data was cleaned and standardized using Excel, including:
Cleaning text formats (TRIM(), PROPER()) to ensure consistency
Adding status columns (e.g., Fraud Confirmed, Suspected, Safe)
Creating dummy data such as:
Tracking numbers (using RANDBETWEEN())
COD / Non-COD status
Investigation outcomes and final resolutions
Adjusting the data structure to make it easier to analyze in Power BI
After preparation, the dataset was used as the main input for Power BI analysis and further exploration using SQL.

Analysis Objectives:
---
1. To understand the proportion of reports that are truly fraud
2. To identify areas or couriers with higher risk
3. To analyze reporting patterns based on payment type (COD vs Non-COD)
4. To evaluate case resolution performance (resolution time)

Power BI: Dashboard Overview & Insights
---
1. KPI Summary (Left Section)
Total Cases – 356
Shows the total number of customer reports received during the analysis period.
This metric represents the overall workload handled by the operations team.

Fraud Confirmed – 18
The number of reports that were confirmed as fraud after investigation.
This indicates that not all reports result from courier or system issues.

Fraud Rate – 5.06%
The percentage of fraud cases compared to total reports.

Insight:
• Although the number of reports is relatively high, only a small portion are confirmed as fraud.
• This highlights the importance of proper validation before taking further action.

//

Avg Resolution Time – 1.67 Days
The average time required to resolve a case.

Insight:
• The investigation process is relatively fast.
• This suggests that the team’s workflow is still fairly efficient.

//

Branch Affected
The number of branches impacted by customer reports.

Employee Affected – 14
The number of couriers involved in reported cases.

Insight:
• Issues are not concentrated in a single location or individual, but spread across multiple branches and employees.

2. Safe vs Suspected Cases
This chart compares:
• Safe → valid / non-problematic reports
• Suspected → reports requiring further investigation

Insight:
Most reports fall under the Safe category, but there is still a significant portion that needs deeper investigation.

3. Investigation Result Breakdown
This visual shows the final outcomes of the investigation process:
• Fake POD → invalid proof of delivery
• System Error → technical issues in the system

Insight:
Most cases are not caused by intentional courier actions, but rather technical constraints or system errors.

4. Fraud vs Non-Fraud Distribution
Shows a comparison between:
• Confirmed fraud cases
• Cases that were not proven to be fraud

Insight:
Although report volume is high, the majority of cases are not confirmed as fraud after investigation.

5. Total Customer Reports & Fraud (Time Trend)
This chart displays:
• Monthly report volume
• Number of fraud cases

Insight:
• Report volume fluctuates over time
• Fraud cases do not always follow spikes in report volume — a high number of reports does not necessarily indicate higher fraud risk

6. Employee Performance
Displays the number of fraud cases by each employee.

Insight:
• Some couriers have higher case counts than others
• This data can be used for:
1. performance evaluation
2. additional training
3. operational monitoring

7. COD vs Non-COD Risk Analysis
Comparison between COD and Non-COD transactions in relation to fraud risk.

Insight:
• COD transactions tend to carry higher fraud risk

MySQL: SQL Analysis & Insights
---

1. Total Case
This query is used to identify the total number of customer reports related to delivered but not received cases recorded in the system.

select count(*) as "Total_Case_Reported"
from fraud_analysis;

Insight:
Serves as the baseline for understanding the volume of cases handled by the operations team.

2. Fraud Rate
Calculates the percentage of confirmed fraud cases compared to total reports.

select 
  Total_Fraud_Confirmed * 100.0 / Total_Case_Reported as "Fraud_Rate_Percentage"
from (
  select
    count(*) as Total_Case_Reported,
    sum(case when Final_Resolution = 'Fraud Confirmed' then 1 else 0 end) as Total_Fraud_Confirmed
  from fraud_analysis
) as result;

Insight:
Most reports do not result in fraud, making validation a critical step before further decision-making.

3. Branch & Employee Affected
Shows the number of branches and employees involved in fraud cases.

select 
    count(distinct branch_name) as branch_affected, 
    count(distinct employee_id) as employee_affected
from fraud_analysis
where final_resolution = "Fraud Confirmed";

Insight:
Cases are not concentrated in a single location or individual, but distributed across multiple branches and employees.

4. Top 2 Employees with Most Fraud Cases
Used to identify employees with the highest number of fraud cases.

select 
    employee_name, 
    employee_id, 
    branch_name,
    sum(case when Final_Resolution = 'Fraud Confirmed' then 1 else 0 end) as Total_Fraud_Confirmed
from fraud_analysis
group by employee_name, employee_id, branch_name
order by Total_Fraud_Confirmed DESC
limit 2;

Insight:
This data can support performance evaluation and help identify areas requiring closer attention.

5. Fraud Cases per Year
Displays the number of fraud cases by reporting year.

select 
    substr(delivered_date, 7, 4) as year_dlv,
    count(*) as total_fraud_cases
from fraud_analysis
where Final_Resolution = "Fraud Confirmed"
group by year_dlv
order by year_dlv;

Insight:
Helps identify yearly trends and determine whether fraud cases are increasing or decreasing over time.

6. Average Resolution Time by Check Result
select 
    Check_Result,
    round(avg(Resolution_Time_Days), 2) as avg_resolution_days
from fraud_analysis
group by Check_Result;

Insight:
Suspected cases require longer resolution times than safe cases, indicating additional verification steps.

Key Conclusions
---
• Most reports do not result in confirmed fraud but still require investigation.
• Fraud tends to occur under specific conditions, such as payment type and certain areas.
• This dashboard helps teams understand risk patterns and improve case-handling efficiency.

---
=================

Bahasa Indonesia 
---
### Project Overview
Project ini dibuat untuk menganalisis laporan pelanggan terkait “Delivered but Not Received”, yaitu kondisi ketika pelanggan melaporkan bahwa paket sudah berstatus terkirim, tetapi barang tidak diterima.

Dataset ini merepresentasikan proses investigasi internal yang biasanya dilakukan oleh tim operasional, khususnya hasil cek terkait:
- Bukti pengiriman (POD),
- Potensi kesalahan sistem,
- Indikasi fraud oleh kurir.

Data yang digunakan merupakan data dummy yang disusun berdasarkan alur kerja nyata dalam proses pengecekan kasus pengiriman bermasalah (fake POD). Struktur data, alur investigasi, dan kategorisasi dibuat menyerupai kondisi di lapangan.

Tools Used
---
• Excel – data cleaning & preparation
• SQL – data aggregation & analysis
• Power BI – visualization & dashboard

NOTE: Dataset ini dibuat untuk keperluan pembelajaran dan portfolio, dengan struktur yang disesuaikan dari pengalaman nyata di bidang operasional dan investigasi pengiriman.

Excel: ## Data Preparation
---
Sebelum dianalisis, data terlebih dahulu dibersihkan dan distandarisasi menggunakan Excel, antara lain:

- Membersihkan format teks (`TRIM()`, `PROPER()`) agar konsisten
- Menambahkan kolom status (misalnya: *Fraud Confirmed, Suspected, Safe*)
- Membuat dummy data seperti:
  * Nomor resi (menggunakan `RANDBETWEEN()`)
  * Status COD/Non-COD
  * Hasil investigasi dan resolusi yang dicapai
- Menyesuaikan struktur data agar mudah dianalisis di Power BI

Setelah itu, data digunakan sebagai dasar analisis di Power BI dan eksplorasi tambahan menggunakan SQL.

Tujuan Analisis:
---
- Mengetahui seberapa besar proporsi laporan yang benar-benar fraud
- Mengidentifikasi area atau kurir dengan risiko lebih tinggi
- Memahami pola laporan berdasarkan jenis pembayaran (COD vs Non-COD)
- Melihat performa penyelesaian kasus (resolution time)


POWER BI: ## Dashboard Overview & Insights
---

1. KPI Summary (Bagian Kiri)
Total Cases – 356
Menunjukkan total laporan customer yang masuk dalam periode analisis.
Angka ini menjadi dasar untuk melihat seberapa besar volume kasus yang harus ditangani tim.

Fraud Confirmed – 18
Jumlah laporan yang setelah dilakukan investigasi dinyatakan sebagai fraud.
Ini menunjukkan bahwa tidak semua laporan berujung pada kesalahan kurir atau sistem.
 
Fraud Rate – 5.06%
Persentase kasus fraud dibandingkan seluruh laporan.
* Insight:
• Walaupun jumlah laporan cukup banyak, hanya sebagian kecil yang benar-benar fraud.
• Ini menunjukkan pentingnya proses validasi sebelum mengambil tindakan lebih lanjut.

--

Avg Resolution Time – 1.67 Days
Rata-rata waktu yang dibutuhkan untuk menyelesaikan satu kasus.

* Insight:
• Proses investigasi relatif cepat.
• Menunjukkan alur kerja tim masih cukup efisien.

--

Branch Affected
Jumlah cabang yang terdampak laporan.

Employee Affected – 14
Jumlah kurir yang terlibat dalam laporan.

* Insight:
• Masalah tidak terpusat pada satu titik saja, tapi tersebar di beberapa cabang dan individu.

--

2. Safe vs Suspected Cases
Diagram ini menunjukkan perbandingan antara:
• Safe → laporan yang valid / tidak bermasalah
• Suspected → laporan yang perlu investigasi lanjutan

* Insight:
Mayoritas laporan berada di kategori Safe, namun tetap ada porsi signifikan yang perlu ditelusuri lebih lanjut.

--

3. Investigation Result Breakdown
Visual ini menampilkan hasil akhir dari proses investigasi:
• Fake POD -> bukti pengiriman tidak valid
• System Error -> kesalahan teknis pada sistem

* Insight:
Sebagian besar kasus bukan karena kesengajaan kurir, melainkan kendala teknis atau kesalahan sistem.

--

4. Fraud vs Non-Fraud Distribution
Menunjukkan perbandingan antara:
• Kasus yang benar-benar fraud
• Kasus yang tidak terbukti fraud
Insight:
Walaupun laporan cukup banyak, mayoritas tidak terbukti sebagai fraud setelah investigasi dilakukan.

--

5. Total Customer Report & Fraud (Trend Waktu)
Grafik ini menunjukkan:
• Jumlah laporan per bulan
• Jumlah kasus fraud yang terjadi
Insight:
• Terlihat fluktuasi laporan dari waktu ke waktu
• Fraud tidak selalu mengikuti lonjakan jumlah laporan -> volume laporan tinggi tidak selalu berarti risiko fraud tinggi

--

6. Employee Performance
Menampilkan jumlah fraud berdasarkan masing-masing employee.

* Insight:
• Beberapa kurir memiliki jumlah kasus lebih tinggi dibanding yang lain
• Data ini dapat digunakan untuk:
	- evaluasi performa
	- pelatihan tambahan
	- monitoring operasional

--

7. COD vs Non-COD Risk Analysis
Perbandingan antara transaksi COD dan Non-COD terhadap risiko fraud.
Insight:
• Transaksi COD memiliki kecenderungan risiko lebih tinggi

---

MySQL: SQL Analysis & Insights
---

1. Total Case
Query ini digunakan untuk mengetahui jumlah total laporan customer terkait delivered but not received yang masuk ke system.

select count(*) as "Total_Case_Reported"
from fraud_analysis;

Insight:
Menjadi dasar untuk memahami volume laporan yang perlu ditangani oleh tim operasional.

--

2. Fraud Rate
Menghitung persentase laporan yang terkonfirmasi sebagai fraud dibandingkan dengan total laporan.

select 
  Total_Fraud_Confirmed * 100.0 / Total_Case_Reported as "Fraud_Rate_Percentage"
from (
  select
    count(*) as Total_Case_Reported,
    sum(case when Final_Resolution = 'Fraud Confirmed' then 1 else 0 end) as Total_Fraud_Confirmed
  from fraud_analysis
) as result;

Insight:
Sebagian besar laporan tidak berujung pada fraud, sehingga proses validasi menjadi langkah penting sebelum pengambilan keputusan lebih lanjut.

--

3. Branch & Employee Affected

Menunjukkan jumlah cabang dan karyawan yang terlibat dalam kasus fraud.

select 
    count(distinct branch_name) as branch_affected, 
    count(distinct employee_id) as employee_affected
from fraud_analysis
where final_resolution = "Fraud Confirmed";

Insight:
Kasus tidak terpusat pada satu lokasi atau individu tertentu, melainkan tersebar di beberapa cabang dan karyawan.

--

4. Top 2 Employee with Most Fraud Cases

Digunakan untuk melihat employee dengan jumlah kasus fraud terbanyak.

select 
    employee_name, 
    employee_id, 
    branch_name,
    sum(case when Final_Resolution = 'Fraud Confirmed' then 1 else 0 end) as Total_Fraud_Confirmed
from fraud_analysis
group by employee_name, employee_id, branch_name
order by Total_Fraud_Confirmed DESC
limit 2;

Insight:
Data ini dapat digunakan sebagai bahan evaluasi performa dan penentuan area yang memerlukan perhatian tambahan.

--

5. Fraud Cases per Year

Menampilkan jumlah kasus fraud berdasarkan tahun laporan.

select 
    substr(delivered_date, 7, 4) as year_dlv,
    count(*) as total_fraud_cases
from fraud_analysis
where Final_Resolution = "Fraud Confirmed"
group by year_dlv
order by year_dlv;

Insight:
Membantu melihat tren tahunan dan mengetahui apakah terdapat peningkatan atau penurunan kasus fraud dari waktu ke waktu.

--

6. average resolution time by Check Result

select 
    Check_Result,
    round(avg(Resolution_Time_Days), 2) as avg_resolution_days
from fraud_analysis
group by Check_Result;

Insight:
Kasus suspected membutuhkan waktu penyelesaian yang lebih lama dibandingkan safe, menunjukkan adanya proses verifikasi tambahan.

---

Kesimpulan Utama
• Mayoritas laporan tidak berujung pada fraud, namun tetap memerlukan proses investigasi.
• Fraud lebih sering muncul pada kondisi tertentu seperti jenis pembayaran dan area tertentu.
• Dashboard ini membantu tim memahami pola risiko dan meningkatkan efisiensi penanganan kasus.
