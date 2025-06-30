import google.generativeai as genai

genai.configure(api_key="AIzaSyDlQnFwzIk55538lEQyETx47Zf2WMuxz8E")  # 👈 insert your real key here

model = genai.GenerativeModel("gemini-pro")

response = model.generate_content("Tell me a Flutter developer joke.")
print(response.text)
