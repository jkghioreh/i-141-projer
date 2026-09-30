let missions=[], activeMission=null, startTime=null, timerHandle=null;

const $=s=>document.querySelector(s);
async function api(url,opts={}){const r=await fetch(url,opts);const d=await r.json();if(!r.ok)throw new Error(d.error||"Erreur");return d}
function escapeHtml(s){return String(s??"").replace(/[&<>"']/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#039;"}[c]))}

async function init(){
  missions=await api("/api/missions");
  $("#missionList").innerHTML=missions.map(m=>`
    <article class="mission" data-id="${m.id}">
      <div class="num">0${m.id}</div><div class="difficulty">${m.difficulty}</div>
      <h3>${escapeHtml(m.title)}</h3><p>${escapeHtml(m.story)}</p>
    </article>`).join("");
  document.querySelectorAll(".mission").forEach(x=>x.onclick=()=>selectMission(Number(x.dataset.id)));
  selectMission(1);
}
function selectMission(id){
  activeMission=missions.find(m=>m.id===id); if(!activeMission)return;
  document.querySelectorAll(".mission").forEach(x=>x.classList.toggle("active",Number(x.dataset.id)===id));
  $("#activeTitle").textContent=activeMission.title; $("#activeDifficulty").textContent=activeMission.difficulty;
  $("#activeStory").textContent=activeMission.story; $("#activeHint").textContent=activeMission.hint;
  $("#feedback").classList.add("hidden"); $("#tableWrap").innerHTML='<div class="empty">Aucune requête exécutée.</div>'; $("#count").textContent="0 ligne";
  $("#sql").value="";
  document.querySelector("#terminal").scrollIntoView({behavior:"smooth",block:"start"});
  startTime=Date.now(); clearInterval(timerHandle); timerHandle=setInterval(updateTimer,1000); updateTimer();
}
function updateTimer(){if(!startTime)return;let s=Math.floor((Date.now()-startTime)/1000),m=Math.floor(s/60);$("#timer").textContent=String(m).padStart(2,"0")+":"+String(s%60).padStart(2,"0")}

$("#run").onclick=async()=>{
  const sql=$("#sql").value.trim(), fb=$("#feedback");
  if(!activeMission)return;
  fb.classList.add("hidden");
  try{
    const d=await api("/api/sql",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({sql,mission_id:activeMission.id})});
    renderTable(d.columns,d.rows); $("#count").textContent=d.row_count+(d.row_count>1?" lignes":" ligne")+(d.truncated?" +":"");
    fb.textContent=d.feedback.message; fb.classList.remove("hidden"); fb.classList.toggle("ok",d.feedback.ok);
  }catch(e){fb.textContent=e.message;fb.classList.remove("hidden");fb.classList.remove("ok");$("#tableWrap").innerHTML='<div class="empty">REQUÊTE REFUSÉE OU INVALIDE.</div>'}
};
function renderTable(cols,rows){
  if(!rows.length){$("#tableWrap").innerHTML='<div class="empty">Aucun résultat.</div>';return}
  $("#tableWrap").innerHTML=`<div style="overflow:auto"><table><thead><tr>${cols.map(c=>`<th>${escapeHtml(c)}</th>`).join("")}</tr></thead><tbody>${rows.map(r=>`<tr>${cols.map(c=>`<td>${escapeHtml(r[c])}</td>`).join("")}</tr>`).join("")}</tbody></table></div>`;
}
$("#clear").onclick=()=>{$("#sql").value="";$("#feedback").classList.add("hidden")};
$("#sql").addEventListener("keydown",e=>{if((e.ctrlKey||e.metaKey)&&e.key==="Enter")$("#run").click()});
init();
