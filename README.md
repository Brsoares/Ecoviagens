# 🌿 EcoViagens: Plataforma de Dados para Turismo Sustentável
**Projeto End-to-End: Da Modelagem SQL à Estratégia de Negócio**

📌 Visão Geral
Este projeto apresenta uma solução completa de dados para a **EcoViagens**, um marketplace de turismo sustentável. O objetivo foi transformar dados brutos de reservas e operações em inteligência de negócio, cobrindo todo o ciclo: modelagem de dados, ingestão, análise via SQL e visualização executiva.

---

## 🔗 Acesso Rápido aos Resultados
* 📊 [**Acessar Dashboard Interativo (Power BI)**]((https://app.powerbi.com/view?r=eyJrIjoiNjZmNzY4ZjMtYzBkNy00NDM4LWI4MTctM2FjNDBlZDEwOTY3IiwidCI6IjIxYjE5YTQzLTZlM2QtNGNjMy1hY2ViLWVkY2VhNjcwYzQ2ZiJ9))
* 📑 [**Ver Apresentação Executiva (Canva)**]((https://canva.link/88hvu2m4ytxwszt))

---

## 🛠️ Stack Tecnológica
* **Banco de Dados:** BigQuery (Google Cloud Platform)
* **Linguagens:** SQL (GoogleSQL) e Python (Pandas para carga/validação)
* **Visualização:** Power BI
* **Design & Comunicação:** Canva (Apresentação Executiva)

---

## 📐 Arquitetura e Modelagem
O coração do projeto é um banco de dados relacional desenhado para suportar o crescimento da plataforma.
* **Modelagem TPT (Table Per Type):** Utilizada para separar entidades de *Hospedagem* e *Atividade*, mantendo a integridade como subtipos de *Oferta*.
* **Escopo:** Dados de Junho/2024 a Junho/2025, integrando Reservas, Clientes, Operadores e Práticas Sustentáveis.

---

## 🔍 Principais Insights (Business Intelligence)
A análise revelou desafios críticos que exigem ações estratégicas:

1. **Instabilidade Financeira:** Receita acumulada de **R$ 663k**, porém com quedas em 6 dos 12 meses analisados.
2. **Desafio de Fidelização:** Apenas **23,3%** dos clientes retornam. O ticket médio do cliente fiel é quase igual ao do cliente único, indicando falta de estratégias de *Upsell*.
3. **Sustentabilidade vs. Valor:** O índice de sustentabilidade está em **67,5%** (abaixo da meta de 90%). Atualmente, os clientes não pagam mais por ofertas com selo ecológico, sugerindo a necessidade de melhor *storytelling*.

---

## 📊 Estrutura dos Dashboards
O relatório no **[Power BI]((https://app.powerbi.com/view?r=eyJrIjoiNjZmNzY4ZjMtYzBkNy00NDM4LWI4MTctM2FjNDBlZDEwOTY3IiwidCI6IjIxYjE5YTQzLTZlM2QtNGNjMy1hY2ViLWVkY2VhNjcwYzQ2ZiJ9))** foi dividido em 5 visões estratégicas:
* **Visão Operação:** Saúde financeira e taxas de cancelamento.
* **Visão Clientes:** Perfil demográfico e funil de fidelização.
* **Visão Ofertas:** Popularidade e análise de ociosidade.
* **Visão Operadores:** Ranking de performance de parceiros.
* **Visão Sustentabilidade:** Monitoramento do propósito ecológico vs. Meta.

<img width="1364" height="762" alt="image" src="https://github.com/user-attachments/assets/7155dc1a-514c-4470-a490-4e92160fab25" />


---

## 🚀 Recomendações Estratégicas
Com base nos dados, propus um plano de ação dividido em horizontes:
* **Curto Prazo:** Lançamento de programa de fidelidade e promoções para meses de baixa.
* **Médio Prazo:** Implementação de badges de "Alta Sustentabilidade" e pacotes casados (Hospedagem + Atividade).
* **Longo Prazo:** Modelagem preditiva para antecipar quedas de receita e expansão do LTV.

---

## 📂 Estrutura do Repositório
* `/sql_scripts`: Queries de criação, limpeza e análise de KPIs.

<img width="649" height="450" alt="image" src="https://github.com/user-attachments/assets/2e475dae-fb92-4737-9577-ec499d3e20ca" />

  
* `/notebooks`: Scripts Python para validação dos dados.

<img width="916" height="798" alt="image" src="https://github.com/user-attachments/assets/d564148b-3aa7-41d1-910c-727ac169d27a" />


* `/images`: Screenshots das telas do Dashboard.

<img width="1362" height="756" alt="image" src="https://github.com/user-attachments/assets/0b1aae0f-4d86-4588-9d1b-681acbb4d97b" />
<img width="1410" height="791" alt="image" src="https://github.com/user-attachments/assets/a7c80dec-4b33-48f9-940d-7c1aeab08483" />
<img width="1383" height="782" alt="image" src="https://github.com/user-attachments/assets/2d33661a-ebac-431d-b7a6-e36fd10c4d34" />




* `apresentacao_ecoviagens.pdf`: Versão exportada da **[Apresentação no Canva](https://canva.link/88hvu2m4ytxwszt)**.

---

## ✍️ Autor
**Bruno Soares**
* [LinkedIn](www.linkedin.com/in/brunosoaresdamata)
* [Portfólio](SEU_LINK_DE_PORTFOLIO_OU_OUTRO_PROJETO)

---
*Dados de referência: EBA*
