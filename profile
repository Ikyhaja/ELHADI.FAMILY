<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ELH4D1 | Edit Profil</title>
<style>
*{box-sizing:border-box;font-family:Inter,Arial,sans-serif}body{margin:0;min-height:100vh;background:linear-gradient(rgba(0,0,0,.72),rgba(0,0,0,.82)),url('hh.jpeg') center/cover fixed;color:#fff;display:flex;align-items:center;justify-content:center;padding:25px}.card{width:min(720px,100%);background:rgba(255,255,255,.06);backdrop-filter:blur(16px);border:1px solid rgba(255,255,255,.12);padding:32px;box-shadow:0 25px 60px rgba(0,0,0,.5)}h1{margin:0 0 6px;letter-spacing:3px}.sub{color:#aaa;font-size:13px;margin-bottom:25px}.grid{display:grid;grid-template-columns:1fr 1fr;gap:15px}.field{display:flex;flex-direction:column;gap:7px}.field.full{grid-column:1/-1}label{font-size:12px;color:#aaa}input,textarea{width:100%;border:1px solid #333;background:rgba(0,0,0,.35);color:#fff;padding:12px;border-radius:7px;outline:none}textarea{min-height:90px;resize:vertical}.btn{border:0;padding:12px 18px;border-radius:7px;cursor:pointer;font-weight:700}.save{background:#00ff88;color:#001b10}.secondary{background:#222;color:#fff;border:1px solid #444}.danger{background:#421b1b;color:#fff;border:1px solid #713333}.actions{display:flex;gap:10px;flex-wrap:wrap;margin-top:22px}.msg{min-height:22px;margin-top:12px;font-size:13px}.avatar{width:82px;height:82px;border-radius:50%;object-fit:cover;border:2px solid #00ff88;background:#222;margin-bottom:12px}@media(max-width:600px){.grid{grid-template-columns:1fr}.field.full{grid-column:auto}}
</style></head>
<body><main class="card">
<img id="avatarPreview" class="avatar" src="https://cdn-icons-png.flaticon.com/512/1077/1077063.png" alt="Foto profil">
<h1>EDIT PROFIL</h1><div class="sub">Data akun tersimpan di MySQL.</div>
<form id="profileForm"><div class="grid">
<div class="field"><label>USERNAME</label><input id="username" required maxlength="30"></div>
<div class="field"><label>EMAIL</label><input id="email" type="email" required maxlength="150"></div>
<div class="field"><label>NAMA LENGKAP</label><input id="full_name" maxlength="100"></div>
<div class="field"><label>NOMOR HP</label><input id="phone" maxlength="30"></div>
<div class="field full"><label>BIO</label><textarea id="bio" maxlength="500"></textarea></div>
<div class="field full"><label>URL FOTO PROFIL</label><input id="avatar_url" placeholder="https://..." maxlength="500"></div>
</div><div class="actions"><button class="btn save" type="submit">SIMPAN PERUBAHAN</button><button class="btn secondary" type="button" onclick="location.href='lobby.html'">KEMBALI</button><button class="btn danger" type="button" onclick="logout()">LOGOUT</button></div><div id="msg" class="msg"></div></form>
<hr style="border:0;border-top:1px solid #333;margin:30px 0"><h2 style="font-size:18px">GANTI PASSWORD</h2><form id="passwordForm"><div class="grid"><div class="field"><label>PASSWORD LAMA</label><input id="current_password" type="password" required></div><div class="field"><label>PASSWORD BARU</label><input id="new_password" type="password" minlength="6" required></div></div><div class="actions"><button class="btn save" type="submit">GANTI PASSWORD</button></div><div id="passMsg" class="msg"></div></form>
</main>
<script src="api-config.js"></script><script>
const msg=document.getElementById('msg'), passMsg=document.getElementById('passMsg');
function show(el,text,ok=false){el.textContent=text;el.style.color=ok?'#00ff88':'#ff7777'}
async function api(path,options={}){const r=await fetch(API_BASE_URL+path,{...options,credentials:'include',headers:{'Content-Type':'application/json',...(options.headers||{})}});let d={};try{d=await r.json()}catch{}if(!r.ok)throw new Error(d.message||'Terjadi kesalahan.');return d}
async function load(){try{const d=await api('/profile.php');const u=d.user;for(const k of ['username','email','full_name','phone','bio','avatar_url'])document.getElementById(k).value=u[k]||'';if(u.avatar_url)document.getElementById('avatarPreview').src=u.avatar_url}catch(e){location.href='login.html'}}
document.getElementById('avatar_url').addEventListener('input',e=>{if(e.target.value)document.getElementById('avatarPreview').src=e.target.value});
document.getElementById('profileForm').addEventListener('submit',async e=>{e.preventDefault();show(msg,'Menyimpan...',true);try{const data=Object.fromEntries(['username','email','full_name','phone','bio','avatar_url'].map(k=>[k,document.getElementById(k).value]));await api('/update-profile.php',{method:'POST',body:JSON.stringify(data)});show(msg,'Profil berhasil diperbarui.',true)}catch(err){show(msg,err.message)}});
document.getElementById('passwordForm').addEventListener('submit',async e=>{e.preventDefault();show(passMsg,'Mengubah password...',true);try{await api('/change-password.php',{method:'POST',body:JSON.stringify({current_password:document.getElementById('current_password').value,new_password:document.getElementById('new_password').value})});show(passMsg,'Password berhasil diubah.',true);e.target.reset()}catch(err){show(passMsg,err.message)}});
async function logout(){try{await api('/logout.php',{method:'POST'})}finally{localStorage.removeItem('elhadi_session');location.href='login.html'}}load();
</script></body></html>
