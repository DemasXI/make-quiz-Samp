//nama pemilik : demasxi

//taruh di admin
new quiz, answers[256], answermade;

CMD:makequiz(playerid, params[])
{
    if(admin_level[playerid] < 3) return 1;
    {
        static
	    tmp[24], string[256], str[256];
	    
	    if(sscanf(params, "s[24]", tmp)) {
	        SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /makequiz [option]");
	        SendClientMessage(playerid, COLOR_GREY, "Options: question, answer, end");
	        SendClientMessage(playerid, COLOR_GREY, "INFO: Please made the answer first.");
	        return 1;
	    }
	    if(!strcmp(tmp, "question", true, 8))
	    {
	        if(sscanf(params, "s[24]s[256]", tmp, str)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /quiz question [question]");
	        if (quiz == 1) return SendClientMessage(playerid, COLOR_GREY, "ERROR : ada quiz yang sedang berjalan gunakan /makequiz end untuk membuat yang baru");
	        if (answermade == 0) return SendClientMessage(playerid, COLOR_GREY, "ERROR : buat jawaban quiz nya dahulu baru yang lain");
	        format(string, sizeof(string), "[QUIZ] : %s", str);
	        SendClientMessageToAll(COLOR_YELLOW, string);
	        SendClientMessageToAll(COLOR_YELLOW, "Gunakan /answer untuk menjawab quiz");
	        quiz = 1;
	    }
	    else if(!strcmp(tmp, "answer", true, 6))
	    {
	      if(sscanf(params, "s[24]s[256]", tmp, str)) return SendClientMessage(playerid, 0xFFFFFF00, "USAGE: /quiz answer [jawaban]");
	      if (quiz == 1) return SendClientMessage(playerid, COLOR_GREY, "ERROR : ada quiz yang sedang berjalan gunakan /makequiz end untuk membuat yang baru");
	      answers = str;
	      answermade = 1;
	      format(string, sizeof(string), "[QUIZ] Kamu telah membuat jawaban quiz berupa : {00FF00}%s", str);
	      SendClientMessage(playerid, COLOR_YELLOW, string);
	    }
	    else if(!strcmp(tmp, "end", true, 3))
	    {
	      if (quiz == 0) return SendClientMessage(playerid, COLOR_GREY, "ERROR : tidak ada quiz yang sedang berjalan");
	      answermade = 0;
	      quiz = 0;
	      answers = "";
	    }
	}
    return 1;
}
//taruh di player
CMD:answer(playerid, params[])
{
  new tmp[256], string[256];
  if (quiz == 0) return SendClientMessage(playerid, COLOR_GREY, "Tidak ada quiz yang sedang berjalan");
  if (sscanf(params, "s[256]", tmp)) return SendClientMessage(playerid, 0xFFFFFF00, "Masuk: /answer [jawaban]");
  if(strcmp(tmp, answers, true)==0)
  {
       format(string, sizeof(string), "[PEMENANG QUIZ] : {00FF00}%s {FFFF00}telah memenang kan quiz dengan jawaban : {00FF00}%s", GetPlayerNameEx(playerid), answers);
       SendClientMessageToAll(COLOR_YELLOW, string);
       Send(playerid,COLOR_GREY, "Jawaban kamu benar!");
       answermade = 0;
       quiz = 0;
       answers = "";
  }
  else
  {
   SendClientMessage(playerid, COLOR_GREY, "Jawaban yang kamu jawab salah!");
  }
  return 1;
}  

//deemasxi
