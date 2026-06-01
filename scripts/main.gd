extends Node2D

const SAVE_PATH := "user://godot_auto_combat_kit.cfg"
const BASE_SIZE := Vector2(720.0, 1280.0)
const WORLD_SIZE := Vector2(2160.0, 3840.0)
const PLAYER_RADIUS := 17.0
const BASE_PLAYER_SPEED := 220.0
const BASE_ATTACK_RANGE := 270.0
const BASE_ATTACK_RATE := 0.38
const PROJECTILE_SPEED := 760.0
const EXTRACTION_ENABLED := false
const EXTRACTION_KILL_TARGET := 28
const EXTRACTION_TIME := 95.0
const BAG_LIMIT := 18
const INITIAL_WEAPON_SLOTS := 2
const INITIAL_CHARM_SLOTS := 2
const MAX_WEAPON_SLOTS := 4
const MAX_CHARM_SLOTS := 4
const BOSS_TIME := 60.0
const INTERACT_RANGE := 82.0
const WEAPON_EVOLVE_LEVEL := 3
const MAX_EFFECTS := 180
const MAX_BEAMS := 36
const MAX_LOOT_ITEMS := 700
const CHEST_OPEN_BASE_COST := 20
const CHEST_OPEN_COST_STEP := 10
const OPENED_CHEST_POP_TIME := 0.18
const MERCHANT_PRICE_STEP := 20
const HIT_FLASH_TIME := 0.62
const NIGHTMARE_GATE_LIFE := 1.9
const NIGHTMARE_GATE_VISUAL_SCALE := 0.36
const NIGHTMARE_GATE_HIT_SCALE := 0.38
const NIGHTMARE_GATE_PULL_START := 18.0
const NIGHTMARE_GATE_PULL_END := 420.0
const AUTO_COMBAT_WEAPON_DEFS := [
	{"id": "aura", "title": "ルーンオーラ", "desc": "周囲の敵にダメージを与える"},
	{"id": "flamewalker", "title": "フレアステップ", "desc": "後ろに火の跡を残す"},
	{"id": "katana", "title": "ムーンスラッシュ", "desc": "近くの敵を狙う鋭い刃"},
	{"id": "dexecutioner", "title": "ジャッジメントブレード", "desc": "貫通する剣。低確率で一撃必殺"},
	{"id": "dice", "title": "フォーチュンルーン", "desc": "運命のルーンを放つ。威力がランダムに変化する"},
	{"id": "aegis", "title": "ルーンシールド", "desc": "敵の攻撃を防ぐ"},
	{"id": "lightning_staff", "title": "ライトニングステッキ", "desc": "雷を呼び出して近くの敵を攻撃する"},
	{"id": "axe", "title": "クレセントアックス", "desc": "回転する斧を投げて範囲ダメージを与える"},
	{"id": "revolver", "title": "シルバーバレット", "desc": "敵に複数の弾丸を撃ち放つ"},
	{"id": "black_hole", "title": "ナイトメアゲート", "desc": "敵を引き寄せる闇の渦を発生させる"},
	{"id": "blood_magic", "title": "ブラッドルーン", "desc": "呪血を召喚する。敵を倒すと低確率で最大HPアップ"},
	{"id": "wireless_dagger", "title": "ホーミングダガー", "desc": "近くの敵へ追尾する短剣を放つ"},
	{"id": "banana", "title": "ルーンブーメラン", "desc": "戻ってくる魔法刃を投げる"},
	{"id": "shotgun", "title": "スプレッドショット", "desc": "近距離で強力な弾幕を放つ"},
	{"id": "sniper_rifle", "title": "シルバースナイプ", "desc": "貫通する弾丸を撃つ"},
	{"id": "fire_staff", "title": "フレアロッド", "desc": "爆発するファイアボールを放つ"},
	{"id": "bow", "title": "セイントアロー", "desc": "貫通する聖なる矢を放つ"},
	{"id": "bone", "title": "バウンドスター", "desc": "敵に跳ね返る星弾を放つ"},
	{"id": "tornado", "title": "ストームサークル", "desc": "竜巻を送り出し、敵を吹き飛ばす"},
	{"id": "frostwalker", "title": "フロストステップ", "desc": "周囲の敵を凍結しダメージを与える"},
	{"id": "chunks", "title": "ルーンロック", "desc": "魔法岩が周囲を回り、近づく敵を砕く"},
	{"id": "space_noodle", "title": "コズミックリボン", "desc": "近くの敵に絡みつき、間の敵にもダメージを与える"},
	{"id": "sword", "title": "ムーンブレード", "desc": "複数の敵を切り裂く"},
	{"id": "landmine", "title": "トラップルーン", "desc": "敵が近づくと爆発するルーン罠を仕掛ける"},
	{"id": "poison_flask", "title": "ベノムボトル", "desc": "毒瓶を投げ、範囲ダメージと毒ダメージを与える"},
	{"id": "dragon_breath", "title": "フレアブレス", "desc": "動いた方向に激しい炎を放つ"},
	{"id": "corrupted_sword", "title": "カースブレード", "desc": "左右から順にクロス斬撃を放つ。HPが低いとダメージ増加"},
	{"id": "hero_sword", "title": "セイントブレード", "desc": "複数の敵を貫きながら斬撃弾を発射する"},
	{"id": "loose_rocket", "title": "マジックミサイル", "desc": "敵を追う魔導弾を放つ"},
	{"id": "blood_scythe", "title": "ブラッドサイス", "desc": "HPが低いほど巨大な血の鎌で周囲を刈り取る"},
	{"id": "gravity_spike", "title": "グラビティスパイク", "desc": "敵の頭上から槍を落とし、周囲に黒い棘を発生させる"},
]
const HIDDEN_WEAPON_IDS := {
	"blood_magic": true,
	"wireless_dagger": true,
	"shotgun": true,
	"sword": true,
}
const ORIGINAL_WEAPON_NAMES := {
	"aura": "Aura",
	"flamewalker": "Flamewalker",
	"katana": "Katana",
	"dexecutioner": "Dexecutioner",
	"dice": "Dice",
	"aegis": "Aegis",
	"lightning_staff": "Lightning Staff",
	"axe": "Axe",
	"revolver": "Revolver",
	"black_hole": "Black Hole",
	"blood_magic": "Blood Magic",
	"wireless_dagger": "Wireless Dagger",
	"banana": "Banana",
	"shotgun": "Shotgun",
	"sniper_rifle": "Sniper Rifle",
	"fire_staff": "Fire Staff",
	"bow": "Bow",
	"bone": "Bone",
	"tornado": "Tornado",
	"frostwalker": "Frostwalker",
	"chunks": "Chunks",
	"space_noodle": "Space Noodle",
	"sword": "Sword",
	"landmine": "Landmine",
	"poison_flask": "Poison Flask",
	"dragon_breath": "Dragon Breath",
	"corrupted_sword": "Corrupted Sword",
	"hero_sword": "Hero Sword",
	"loose_rocket": "Loose Rocket",
	"blood_scythe": "Blood Scythe",
	"gravity_spike": "Gravity Spike",
}
const WEAPON_UPGRADE_STAT_OPTIONS := {
	"aura": ["damage", "cooldown", "range", "size", "duration"],
	"flamewalker": ["damage", "range", "size", "duration"],
	"katana": ["damage", "cooldown", "range", "size", "crit_chance", "knockback"],
	"dexecutioner": ["damage", "cooldown", "range", "size", "crit_chance", "pierce"],
	"dice": ["damage", "cooldown", "projectiles", "projectile_speed", "crit_chance"],
	"aegis": ["damage", "cooldown", "range", "size", "knockback"],
	"lightning_staff": ["damage", "cooldown", "range", "size", "status_chance"],
	"axe": ["damage", "cooldown", "range", "projectiles", "size", "projectile_speed", "pierce", "knockback"],
	"revolver": ["damage", "cooldown", "projectiles", "projectile_speed", "pierce", "crit_chance", "knockback"],
	"black_hole": ["damage", "cooldown", "range", "size", "duration", "knockback"],
	"blood_magic": ["damage", "cooldown", "range", "size", "crit_chance", "status_chance"],
	"wireless_dagger": ["damage", "cooldown", "projectiles", "projectile_speed", "pierce", "crit_chance"],
	"banana": ["damage", "cooldown", "range", "projectiles", "size", "projectile_speed", "knockback"],
	"shotgun": ["damage", "cooldown", "projectiles", "projectile_speed", "size", "knockback"],
	"sniper_rifle": ["damage", "cooldown", "projectile_speed", "pierce", "crit_chance", "knockback"],
	"fire_staff": ["damage", "cooldown", "range", "projectiles", "size", "projectile_speed", "pierce", "status_chance"],
	"bow": ["damage", "cooldown", "projectiles", "projectile_speed", "pierce", "crit_chance"],
	"bone": ["damage", "cooldown", "projectiles", "size", "projectile_speed", "pierce", "knockback"],
	"tornado": ["damage", "cooldown", "range", "size", "duration", "knockback"],
	"frostwalker": ["damage", "cooldown", "range", "size", "duration", "status_chance"],
	"chunks": ["damage", "cooldown", "projectiles", "range", "size", "projectile_speed", "duration"],
	"space_noodle": ["damage", "cooldown", "projectiles", "range", "duration", "pierce"],
	"sword": ["damage", "cooldown", "range", "size", "crit_chance", "knockback"],
	"landmine": ["damage", "cooldown", "range", "size", "duration", "projectiles", "knockback"],
	"poison_flask": ["damage", "cooldown", "range", "size", "duration", "projectile_speed", "status_chance"],
	"dragon_breath": ["damage", "cooldown", "range", "size", "duration", "status_chance", "knockback"],
	"corrupted_sword": ["damage", "cooldown", "range", "size", "crit_chance", "knockback"],
	"hero_sword": ["damage", "cooldown", "range", "size", "projectile_speed", "pierce", "crit_chance"],
	"loose_rocket": ["damage", "cooldown", "range", "projectiles", "size", "projectile_speed", "pierce", "knockback"],
	"blood_scythe": ["damage", "cooldown", "range", "size", "crit_chance"],
	"gravity_spike": ["damage", "cooldown", "range", "size", "duration", "knockback"],
}
const WEAPON_BASE_STATS := {
	"aura": {"damage": 1.0, "cooldown": 0.78, "range": 84.0, "size": 1.0, "duration": 0.0},
	"flamewalker": {"damage": 0.42, "cooldown": 0.42, "range": 78.0, "size": 1.0, "duration": 2.4},
	"katana": {"damage": 1.55, "cooldown": 1.15, "range": 138.0, "size": 1.0, "crit_chance": 0.0, "knockback": 0.0},
	"dexecutioner": {"damage": 1.35, "cooldown": 1.65, "range": 124.0, "size": 1.0, "crit_chance": 0.31, "pierce": 1},
	"dice": {"damage": 1.3, "cooldown": 1.65, "projectiles": 1, "projectile_speed": 620.0, "crit_chance": 0.0},
	"aegis": {"damage": 0.82, "cooldown": 1.25, "range": 104.0, "size": 1.0, "knockback": 0.0},
	"lightning_staff": {"damage": 1.0, "cooldown": 1.65, "range": 260.0, "size": 1.0, "status_chance": 0.0},
	"axe": {"damage": 0.82, "cooldown": 1.65, "range": 144.0, "projectiles": 1, "size": 1.0, "projectile_speed": 690.0, "pierce": 2, "knockback": 0.0},
	"revolver": {"damage": 0.82, "cooldown": 0.72, "projectiles": 2, "projectile_speed": 920.0, "pierce": 0, "crit_chance": 0.0, "knockback": 18.0},
	"black_hole": {"damage": 0.82, "cooldown": 2.7, "range": 168.0, "size": 1.0, "duration": 1.35, "knockback": 42.0},
	"blood_magic": {"damage": 1.18, "cooldown": 1.55, "range": 126.0, "size": 1.0, "crit_chance": 0.0, "status_chance": 0.0},
	"wireless_dagger": {"damage": 0.72, "cooldown": 1.15, "projectiles": 3, "projectile_speed": 780.0, "pierce": 0, "crit_chance": 0.0},
	"banana": {"damage": 0.74, "cooldown": 2.15, "range": 150.0, "projectiles": 1, "size": 1.0, "projectile_speed": 640.0, "knockback": 0.0},
	"shotgun": {"damage": 0.58, "cooldown": 1.15, "projectiles": 5, "projectile_speed": 820.0, "size": 1.0, "knockback": 26.0},
	"sniper_rifle": {"damage": 2.6, "cooldown": 2.7, "projectile_speed": 1120.0, "pierce": 2, "crit_chance": 0.0, "knockback": 34.0},
	"fire_staff": {"damage": 1.05, "cooldown": 1.65, "range": 0.0, "projectiles": 1, "size": 1.0, "projectile_speed": 600.0, "pierce": 1, "status_chance": 0.0},
	"bow": {"damage": 0.72, "cooldown": 0.72, "projectiles": 2, "projectile_speed": 900.0, "pierce": 0, "crit_chance": 0.0},
	"bone": {"damage": 0.92, "cooldown": 1.65, "projectiles": 1, "size": 1.0, "projectile_speed": 680.0, "pierce": 1, "knockback": 0.0},
	"tornado": {"damage": 0.9, "cooldown": 2.15, "range": 104.0, "size": 1.0, "duration": 0.0, "knockback": 0.0},
	"frostwalker": {"damage": 0.34, "cooldown": 0.42, "range": 82.0, "size": 1.0, "duration": 2.6, "status_chance": 1.0},
	"chunks": {"damage": 1.02, "cooldown": 1.65, "projectiles": 1, "range": 72.0, "size": 1.0, "projectile_speed": 760.0, "duration": 2.2},
	"space_noodle": {"damage": 0.58, "cooldown": 1.65, "projectiles": 4, "range": 0.0, "duration": 0.72, "pierce": 0},
	"sword": {"damage": 1.12, "cooldown": 1.25, "range": 89.0, "size": 1.0, "crit_chance": 0.0, "knockback": 0.0},
	"landmine": {"damage": 1.45, "cooldown": 2.15, "range": 114.0, "size": 1.0, "duration": 6.35, "projectiles": 1, "knockback": 0.0},
	"poison_flask": {"damage": 0.58, "cooldown": 2.15, "range": 130.0, "size": 1.0, "duration": 3.6, "projectile_speed": 560.0, "status_chance": 1.0},
	"dragon_breath": {"damage": 1.0, "cooldown": 1.55, "range": 166.0, "size": 1.0, "duration": 0.24, "status_chance": 0.0, "knockback": 0.0},
	"corrupted_sword": {"damage": 2.1, "cooldown": 2.7, "range": 114.0, "size": 1.0, "crit_chance": 0.0, "knockback": 0.0},
	"hero_sword": {"damage": 2.0, "cooldown": 1.65, "range": 170.0, "size": 1.0, "projectile_speed": 0.0, "pierce": 1, "crit_chance": 0.0},
	"loose_rocket": {"damage": 1.05, "cooldown": 2.7, "range": 186.0, "projectiles": 1, "size": 1.0, "projectile_speed": 760.0, "pierce": 1, "knockback": 0.0},
	"blood_scythe": {"damage": 1.55, "cooldown": 1.85, "range": 96.0, "size": 1.0, "crit_chance": 0.0},
	"gravity_spike": {"damage": 1.8, "cooldown": 2.45, "range": 150.0, "size": 1.0, "duration": 0.45, "knockback": 0.0},
}
const WEAPON_STAT_UPGRADE_RANGES := {
	"damage": {"normal": [0.06, 0.10], "uncommon": [0.09, 0.14], "common": [0.12, 0.18], "epic": [0.20, 0.30], "legendary": [0.32, 0.48]},
	"cooldown": {"normal": [0.035, 0.06], "uncommon": [0.055, 0.085], "common": [0.075, 0.11], "epic": [0.12, 0.18], "legendary": [0.20, 0.28]},
	"range": {"normal": [0.06, 0.10], "uncommon": [0.09, 0.14], "common": [0.12, 0.18], "epic": [0.20, 0.30], "legendary": [0.32, 0.46]},
	"size": {"normal": [0.05, 0.09], "uncommon": [0.08, 0.13], "common": [0.11, 0.17], "epic": [0.18, 0.28], "legendary": [0.30, 0.42]},
	"duration": {"normal": [0.06, 0.10], "uncommon": [0.09, 0.14], "common": [0.12, 0.18], "epic": [0.20, 0.30], "legendary": [0.32, 0.46]},
	"projectile_speed": {"normal": [0.06, 0.10], "uncommon": [0.09, 0.14], "common": [0.12, 0.18], "epic": [0.20, 0.30], "legendary": [0.32, 0.46]},
	"crit_chance": {"normal": [0.03, 0.05], "uncommon": [0.05, 0.075], "common": [0.07, 0.10], "epic": [0.11, 0.16], "legendary": [0.18, 0.25]},
	"knockback": {"normal": [0.08, 0.13], "uncommon": [0.12, 0.18], "common": [0.16, 0.24], "epic": [0.28, 0.40], "legendary": [0.45, 0.65]},
	"status_chance": {"normal": [0.04, 0.07], "uncommon": [0.06, 0.10], "common": [0.09, 0.14], "epic": [0.16, 0.24], "legendary": [0.28, 0.40]},
	"projectiles": {"normal": [1, 1], "uncommon": [1, 1], "common": [1, 2], "epic": [2, 2], "legendary": [2, 3]},
	"pierce": {"normal": [1, 1], "uncommon": [1, 1], "common": [1, 2], "epic": [2, 3], "legendary": [3, 4]},
}
const WEAPON_ICON_PATHS := {
	"aura": "res://assets/weapon_icons/aura.png",
	"flamewalker": "res://assets/weapon_icons/flamewalker.png",
	"katana": "res://assets/weapon_icons/katana.png",
	"dexecutioner": "res://assets/weapon_icons/dexecutioner.png",
	"dice": "res://assets/weapon_icons/dice.png",
	"aegis": "res://assets/weapon_icons/aegis.png",
	"lightning_staff": "res://assets/weapon_icons/lightning_staff.png",
	"axe": "res://assets/weapon_icons/axe.png",
	"revolver": "res://assets/weapon_icons/revolver.png",
	"black_hole": "res://assets/weapon_icons/black_hole.png",
	"blood_magic": "res://assets/weapon_icons/blood_magic.png",
	"wireless_dagger": "res://assets/weapon_icons/wireless_dagger.png",
	"banana": "res://assets/weapon_icons/banana.png",
	"shotgun": "res://assets/weapon_icons/shotgun.png",
	"sniper_rifle": "res://assets/weapon_icons/sniper_rifle.png",
	"fire_staff": "res://assets/weapon_icons/fire_staff.png",
	"bow": "res://assets/weapon_icons/bow.png",
	"bone": "res://assets/weapon_icons/bone.png",
	"tornado": "res://assets/weapon_icons/tornado.png",
	"frostwalker": "res://assets/weapon_icons/frostwalker.png",
	"chunks": "res://assets/weapon_icons/chunks.png",
	"space_noodle": "res://assets/weapon_icons/space_noodle.png",
	"sword": "res://assets/weapon_icons/sword.png",
	"landmine": "res://assets/weapon_icons/landmine.png",
	"poison_flask": "res://assets/weapon_icons/poison_flask.png",
	"dragon_breath": "res://assets/weapon_icons/dragon_breath.png",
	"corrupted_sword": "res://assets/weapon_icons/corrupted_sword.png",
	"hero_sword": "res://assets/weapon_icons/hero_sword.png",
	"loose_rocket": "res://assets/weapon_icons/loose_rocket.png",
	"blood_scythe": "res://assets/weapons/blood_scythe.png",
	"gravity_spike": "res://assets/weapons/gravity_spike_spear.png",
}
const CHARM_ICON_PATHS := {
	"xp_gain": "res://assets/charm_icons/xp_gain.png",
	"luck": "res://assets/charm_icons/luck.png",
	"cursed_tome": "res://assets/charm_icons/cursed_tome.png",
	"chaos_tome": "res://assets/charm_icons/chaos_tome.png",
	"damage": "res://assets/charm_icons/damage.png",
	"crit_chance": "res://assets/charm_icons/crit_chance.png",
	"cooldown_tome": "res://assets/charm_icons/cooldown_tome.png",
	"size_tome": "res://assets/charm_icons/size_tome.png",
	"armor": "res://assets/charm_icons/armor.png",
	"projectile_speed": "res://assets/charm_icons/projectile_speed.png",
	"thorns": "res://assets/charm_icons/thorns.png",
	"lifesteal_chance": "res://assets/charm_icons/lifesteal_chance.png",
	"shield": "res://assets/charm_icons/shield.png",
	"gold_gain": "res://assets/charm_icons/gold_gain.png",
	"projectiles": "res://assets/charm_icons/projectiles.png",
	"golden_tome": "res://assets/charm_icons/golden_tome.png",
	"magnet": "res://assets/charm_icons/magnet.png",
	"evasion": "res://assets/charm_icons/evasion.png",
	"regen": "res://assets/charm_icons/regen.png",
	"max_hp": "res://assets/charm_icons/max_hp.png",
	"speed": "res://assets/charm_icons/speed.png",
	"knockback": "res://assets/charm_icons/knockback.png",
	"duration": "res://assets/charm_icons/duration.png",
}
const TREASURE_DEFS := [
	{"id": "key", "rarity": "common", "title": "キー", "desc": "宝箱をただであける確率+10％"},
	{"id": "wrench", "rarity": "common", "title": "オーブ", "desc": "祭壇のチャージが早くなり、品質も上がる"},
	{"id": "cheese", "rarity": "common", "title": "ポイズンジェム", "desc": "攻撃時、40％の確率で毒を付与する"},
	{"id": "gym_sauce", "rarity": "common", "title": "パワーポーション", "desc": "ダメージ+10％"},
	{"id": "time_bracelet", "rarity": "common", "title": "クロックバングル", "desc": "経験値8％増加"},
	{"id": "boss_buster", "rarity": "common", "title": "ボスキラー", "desc": "エリートとボスに+15％の追加ダメージ"},
	{"id": "clover", "rarity": "common", "title": "ラックリーフ", "desc": "運が7.5％増加"},
	{"id": "golden_glove", "rarity": "common", "title": "ゴールドガントレット", "desc": "敵を倒すと+15％追加のゴールド獲得"},
	{"id": "oats", "rarity": "common", "title": "ライフシード", "desc": "最大HPが25増加"},
	{"id": "turbo_socks", "rarity": "common", "title": "スピードブーツ", "desc": "移動速度+15％"},
	{"id": "tactical_glasses", "rarity": "common", "title": "ハンターグラス", "desc": "HP90％以上の敵に+20％追加ダメージ"},
	{"id": "battery", "rarity": "common", "title": "ライトニングコア", "desc": "攻撃速度+8％"},
	{"id": "forbidden_juice", "rarity": "common", "title": "カースポーション", "desc": "クリティカルチャンス+10％"},
	{"id": "cursed_doll", "rarity": "common", "title": "カースドール", "desc": "毎秒最大HPの30％のダメージ"},
	{"id": "ice_crystal", "rarity": "common", "title": "フロストクリスタル", "desc": "7.5％で敵を凍らせる"},
	{"id": "skull_egg", "rarity": "common", "title": "スカルエッグ", "desc": "難易度+7％"},
	{"id": "ghost", "rarity": "common", "title": "ソウルゴースト", "desc": "インタラクトするとゴースト召喚"},
	{"id": "cactus", "rarity": "common", "title": "スパイクチャーム", "desc": "ダメージを受けるとトゲ発射 ダメージはスパイクに比例"},
	{"id": "burger", "rarity": "common", "title": "ヒールオーブ", "desc": "敵を倒すと+2％の確率で回復オーブ出現"},
	{"id": "medkit", "rarity": "common", "title": "セイントキット", "desc": "HPリジェネが+45増加"},
	{"id": "red_credit_card", "rarity": "rare", "title": "レッドタリスマン", "desc": "宝箱を開けると+2.5％ダメージアップ"},
	{"id": "backpack", "rarity": "rare", "title": "マジックバッグ", "desc": "全ての武器の弾数を+1"},
	{"id": "echo_shard", "rarity": "rare", "title": "エコークリスタル", "desc": "敵を倒すと+12％の確率で追加の経験値"},
	{"id": "idle_juice", "rarity": "rare", "title": "ステイポーション", "desc": "立ち止まってるとダメージ増加 最大100％ダメージ"},
	{"id": "unstable_transfusion", "rarity": "rare", "title": "ブラッドパック", "desc": "攻撃時+27％の確率でブラッドマークを付与"},
	{"id": "golden_shield", "rarity": "rare", "title": "ゴールドラッシュ", "desc": "ダメージを受けるとゴールド入手"},
	{"id": "kevin", "rarity": "rare", "title": "カースドミニオン", "desc": "攻撃すると呪われた使い魔があなたを攻撃する"},
	{"id": "beacon", "rarity": "rare", "title": "セイントビーコン", "desc": "チャージすると祭壇が回復ゾーンに。次のステージの祭壇+2箇所"},
	{"id": "thunder_mitt", "rarity": "rare", "title": "サンダーミット", "desc": "敵を叩くと電気攻撃。10秒で再充電"},
	{"id": "beer", "rarity": "rare", "title": "バーサークポーション", "desc": "+20％ダメージ増加。最大HPが5％減少"},
	{"id": "feather", "rarity": "rare", "title": "ウィンドフェザー", "desc": "さらに高く遠くへジャンプ"},
	{"id": "electric_plug", "rarity": "rare", "title": "スパークプラグ", "desc": "ダメージを受けると近くの敵に電気攻撃"},
	{"id": "coward_cape", "rarity": "rare", "title": "シャドウマント", "desc": "移動速度が上がる。敵に攻撃されると更に+5％"},
	{"id": "phantom_shroud", "rarity": "rare", "title": "ファントムヴェール", "desc": "回避後の攻撃2倍、一時的に攻撃速度と移動速度UP"},
	{"id": "knuckle_duster", "rarity": "rare", "title": "アイアンナックル", "desc": "近くの敵に+20％ダメージアップ"},
	{"id": "demon_blade", "rarity": "rare", "title": "デモンブレード", "desc": "クリティカルで+25％の確率で体力回復"},
	{"id": "demon_blood", "rarity": "rare", "title": "デモンブラッド", "desc": "キル毎に最大HPが+0.5アップ（最大200スタック）"},
	{"id": "moldy_glove", "rarity": "rare", "title": "ポイズングローブ", "desc": "敵を殴ると毒霧発生"},
	{"id": "golden_sneakers", "rarity": "rare", "title": "ゴールドブーツ", "desc": "動いているとゴールド入手"},
	{"id": "vampire_crystal", "rarity": "rare", "title": "ヴァンパイアクリスタル", "desc": "最大HP50上昇、リジェネ量-50％"},
	{"id": "muscle_ring", "rarity": "epic", "title": "パワーリング", "desc": "最大HP100毎にダメージ+20％"},
	{"id": "green_credit_card", "rarity": "epic", "title": "グリーンタリスマン", "desc": "宝箱開ける毎に運+2％"},
	{"id": "grandma_tonic", "rarity": "epic", "title": "シークレットトニック", "desc": "クリティカルの50％の確率で周囲の敵に50％ダメージ"},
	{"id": "cursed_gravy", "rarity": "epic", "title": "カースグレイビー", "desc": "難易度+10％ 最大HP0.8倍 敵ヒットで5％の確率で呪い魔法"},
	{"id": "mirror", "rarity": "epic", "title": "ルナミラー", "desc": "受けたダメージを反射し短時間の無敵を獲得"},
	{"id": "demon_soul", "rarity": "epic", "title": "デモンソウル", "desc": "キル毎にダメージ増加（最大100％）"},
	{"id": "spiked_shield", "rarity": "epic", "title": "スパイクシールド", "desc": "アーマー1％毎にスパイク+2。アーマー10％"},
	{"id": "slurp_glove", "rarity": "epic", "title": "ブラッドグローブ", "desc": "敵を攻撃で血の魔法発動。周囲にダメージと+7.5％回復。クールタイム9秒"},
	{"id": "scarf", "rarity": "epic", "title": "ウィンドスカーフ", "desc": "空中でダメージ33％増加"},
	{"id": "roller_blades", "rarity": "epic", "title": "ローラーブーツ", "desc": "動くほど攻撃速度増加、スタックごと最大40％"},
	{"id": "loose_cannon", "rarity": "epic", "title": "ルーンキャノン", "desc": "敵を倒すと20％の確率でミサイル発射"},
	{"id": "fragmented_knowledge", "rarity": "epic", "title": "フラグメントロア", "desc": "XPシャードが敵を切り裂きダメージを与える"},
	{"id": "quin_mask", "rarity": "epic", "title": "クインマスク", "desc": "トゲダメージで50％の確率で爆発し、周囲の敵にダメージ"},
	{"id": "poison_barrel", "rarity": "epic", "title": "ポイズンバレル", "desc": "ダメージを受けると近くの敵を毒状態に"},
	{"id": "gas_mask", "rarity": "epic", "title": "ミストマスク", "desc": "毒に感染した敵ごとにアーマーとオーバーヒール獲得"},
	{"id": "gamer_goggles", "rarity": "epic", "title": "バトルゴーグル", "desc": "HPが低いほどダメージ増加"},
	{"id": "eagle_claw", "rarity": "epic", "title": "イーグルクロー", "desc": "空中の敵に+66％ダメージ。8％で敵を打ち上げる"},
	{"id": "bob", "rarity": "epic", "title": "サモンベル", "desc": "14ユニット移動するごとに使い魔を召喚"},
	{"id": "lamp", "rarity": "legendary", "title": "奴隷は2度刺す", "desc": "ヒット時の効果を+1回発生"},
	{"id": "the_world", "rarity": "legendary", "title": "神の悪戯", "desc": "致命傷を受けた時に時間を止める。一度だけ"},
	{"id": "suction_magnet", "rarity": "legendary", "title": "月の引力", "desc": "定期的に周囲の経験値を引き寄せる"},
	{"id": "anvil", "rarity": "legendary", "title": "巨匠", "desc": "武器のアップグレードに+1個のステータス"},
	{"id": "soul_harvester", "rarity": "legendary", "title": "魂を刈る大鎌", "desc": "敵を倒すと2個の追尾ソウルを召喚"},
	{"id": "big_bonk", "rarity": "legendary", "title": "幸運の鉄槌", "desc": "2％の確率でBONK発動。20倍のダメージを与える"},
	{"id": "chonk_plate", "rarity": "legendary", "title": "血を啜りし物", "desc": "回復が最大HPを超えると75％だけオーバーヒール。また20％のライフ吸収を獲得"},
	{"id": "joe_dagger", "rarity": "legendary", "title": "斬首", "desc": "1％で敵を処刑、処刑成功時にダメージ1％上昇"},
	{"id": "bloody_cleaver", "rarity": "legendary", "title": "血濡れた刃", "desc": "ライフ吸収でブラッドマーク付与。更に50％の確率でブラッドマーク付与"},
	{"id": "dragon_fire", "rarity": "legendary", "title": "竜の吐息", "desc": "攻撃すると15％でドラゴンファイア発動、更に燃焼を付与"},
	{"id": "holy_book", "rarity": "legendary", "title": "女神の祈り", "desc": "最大HP+100、リジェネ+50、回復が近くの敵にダメージ"},
	{"id": "lightning_orb", "rarity": "legendary", "title": "雷獣", "desc": "25％の確率で落雷を召喚、敵をスタンさせる"},
	{"id": "spicy_meatball", "rarity": "legendary", "title": "炎の怒り", "desc": "攻撃が25％の確率で爆発し周囲の敵に65％ダメージ"},
	{"id": "ice_cube", "rarity": "legendary", "title": "絶対零度", "desc": "敵を攻撃した時に氷ダメージと凍結"},
	{"id": "giant_fork", "rarity": "legendary", "title": "神殺し", "desc": "クリティカルが一定確率でメガクリティカルになる"},
	{"id": "power_glove", "rarity": "legendary", "title": "爆発は芸術", "desc": "敵ヒットで8％の確率で大爆発、ダメージと吹き飛ばし"},
	{"id": "energy_core", "rarity": "legendary", "title": "魔導核", "desc": "的に向かってエナジーオーブを発射する"},
	{"id": "speed_boy", "rarity": "legendary", "title": "刹那の瞬き", "desc": "HP50％以下で時間がスローに。更にダメージ2倍"},
]
const BACKGROUND_TEXTURE := preload("res://assets/backgrounds/dungeon_arena.png")
const PLAYER_RIGHT_PATH := "res://assets/characters/player_navy_right.png"
const PLAYER_LEFT_PATH := "res://assets/characters/player_navy_left.png"
const PLAYER_SPRITE_HEIGHT := 72.0
const SAINT_ARROW_PATH := "res://assets/weapons/saint_arrow.png"
const SAINT_ARROW_SPRITE_HEIGHT := 28.0
const SILVER_BULLET_PATH := "res://assets/weapons/silver_bullet.png"
const SILVER_BULLET_SPRITE_HEIGHT := 18.0
const HOMING_DAGGER_PATH := "res://assets/weapons/homing_dagger.png"
const HOMING_DAGGER_SPRITE_HEIGHT := 34.0
const RUNE_BOOMERANG_PATH := "res://assets/weapons/rune_boomerang.png"
const RUNE_BOOMERANG_SPRITE_HEIGHT := 44.0
const MAGIC_MISSILE_PATH := "res://assets/weapons/magic_missile.png"
const MAGIC_MISSILE_SPRITE_HEIGHT := 34.0
const TRAP_RUNE_PATH := "res://assets/weapons/trap_rune.png"
const TRAP_RUNE_SPRITE_HEIGHT := 58.0
const BOUND_STAR_PATH := "res://assets/weapons/bound_star.png"
const BOUND_STAR_SPRITE_HEIGHT := 30.0
const CRESCENT_AXE_PATH := "res://assets/weapons/crescent_axe.png"
const CRESCENT_AXE_SPRITE_HEIGHT := 44.0
const FORTUNE_RUNE_PATH := "res://assets/weapons/fortune_rune.png"
const FORTUNE_RUNE_SPRITE_HEIGHT := 34.0
const VENOM_BOTTLE_PATH := "res://assets/weapons/venom_bottle.png"
const VENOM_BOTTLE_SPRITE_HEIGHT := 34.0
const BLOOD_SCYTHE_PATH := "res://assets/weapons/blood_scythe.png"
const GRAVITY_SPIKE_SPEAR_PATH := "res://assets/weapons/gravity_spike_spear.png"
const GRAVITY_SPIKE_SPIKES_SHEET_PATH := "res://assets/effects/attacks/gravity_spike_spikes_sheet.png"
const FLAME_STEP_EFFECT_PATH := "res://assets/effects/flame_step.png"
const FLAME_TRAIL_EFFECT_PATH := "res://assets/effects/flame_trail.png"
const FLAME_RING_EFFECT_PATH := "res://assets/effects/flame_ring.png"
const LIGHTNING_STRIKE_PATH := "res://assets/effects/lightning_strike.png"
const NIGHTMARE_GATE_PATH := "res://assets/effects/attacks/nightmare_gate_sheet.png"
const SMOOTH_ATTACK_FRAME_COUNT := 12
const NIGHTMARE_GATE_FRAME_COUNT := SMOOTH_ATTACK_FRAME_COUNT
const ATTACK_EFFECT_PATHS := {
	"flare_rod": "res://assets/effects/attacks/flare_rod.png",
	"rune_rock": "res://assets/effects/attacks/rune_rock.png",
	"moon_blade": "res://assets/effects/attacks/moon_blade.png",
	"flare_breath": "res://assets/effects/attacks/flare_breath_sheet.png",
	"storm_circle": "res://assets/effects/attacks/storm_circle.png",
	"trap_explosion": "res://assets/effects/attacks/trap_explosion_sheet.png",
	"venom_splash": "res://assets/effects/attacks/venom_splash_sheet.png",
	"magic_missile_explosion": "res://assets/effects/attacks/magic_missile_explosion_sheet.png",
	"cosmic_ribbon": "res://assets/effects/attacks/cosmic_ribbon.png",
	"curse_blade": "res://assets/effects/attacks/curse_blade.png",
	"blood_scythe": BLOOD_SCYTHE_PATH,
	"gravity_spike_spikes": GRAVITY_SPIKE_SPIKES_SHEET_PATH,
}
const KATANA_SLASH_BLUE_PATH := "res://assets/effects/katana_slash_blue.jpg"
const KATANA_SLASH_GOLD_PATH := "res://assets/effects/katana_slash_gold.jpg"
const FLAME_STEP_ORANGE_PATH := "res://assets/effects/flame_step_orange.jpg"
const FLAME_STEP_BLUE_PATH := "res://assets/effects/flame_step_blue.jpg"
const ENEMY_GHOST_RIGHT_PATH := "res://assets/enemies/ghost_right.png"
const ENEMY_GHOST_LEFT_PATH := "res://assets/enemies/ghost_left.png"
const ENEMY_GHOST_SPRITE_HEIGHT := 46.0
const ENEMY_SHADOW_CAT_RIGHT_PATH := "res://assets/enemies/shadow_cat_right.png"
const ENEMY_SHADOW_CAT_LEFT_PATH := "res://assets/enemies/shadow_cat_left.png"
const ENEMY_SHADOW_CAT_SPRITE_HEIGHT := 54.0
const BOSS_DARK_KNIGHT_RIGHT_PATH := "res://assets/bosses/dark_knight_boss_right.png"
const BOSS_DARK_KNIGHT_LEFT_PATH := "res://assets/bosses/dark_knight_boss_left.png"
const BOSS_DARK_KNIGHT_SPRITE_HEIGHT := 170.0
const LOOT_XP_CRYSTAL_PATH := "res://assets/loot/xp_crystal.png"
const LOOT_COIN_PATH := "res://assets/loot/coin.png"
const INTERACTABLE_TEXTURE_PATHS := {
	"chest": "res://assets/interactables/chest.png",
	"chest_open": "res://assets/interactables/chest_open.png",
	"locked_chest": "res://assets/interactables/locked_chest.png",
	"pot": "res://assets/interactables/pot.png",
	"altar": "res://assets/interactables/altar.png",
	"altar_used": "res://assets/interactables/altar_used.png",
}
const INTERACTABLE_SPRITE_HEIGHTS := {
	"chest": 74.0,
	"chest_open": 78.0,
	"locked_chest": 78.0,
	"pot": 68.0,
	"altar": 106.0,
	"altar_used": 106.0,
}

var rng := RandomNumberGenerator.new()
var player_pos := Vector2.ZERO
var target_pos := Vector2.ZERO
var camera_pos := Vector2.ZERO
var touch_active := false
var player_facing_right := true
var player_is_moving := false
var player_move_dir := Vector2.DOWN
var player_hp := 100
var max_hp := 100
var player_level := 1
var xp := 0
var xp_next := 10
var displayed_xp_ratio := 0.0
var kills := 0
var elapsed := 0.0
var attack_timer := 0.0
var regen_timer := 0.0
var shield_recharge_timer := 0.0
var player_shield := 0
var spawn_timer := 0.0
var elite_timer := 22.0
var lightning_timer := 0.0
var mine_timer := 0.0
var event_timer := 0.0
var drone_angle := 0.0
var dash_cooldown := 0.0
var extract_open := false
var run_over := false
var choice_open := false
var chest_reward_open := false
var chest_reward_time := 0.0
var pending_chest_reward := {}
var pending_chest_reward_pos := Vector2.ZERO
var pending_chest_reward_locked := false
var altar_relic_choice_open := false
var altar_relic_choice_time := 0.0
var offered_altar_relics: Array[Dictionary] = []
var altar_relic_choice_pos := Vector2.ZERO
var merchant_choice_open := false
var merchant_choice_time := 0.0
var offered_merchant_relics: Array[Dictionary] = []
var merchant_choice_pos := Vector2.ZERO
var merchant_choice_index := -1
var merchant_purchase_count := 0
var chest_open_count := 0
var minimap_open := false
var started := false
var boss_spawned := false
var test_mode := false
var test_weapon_index := 0
var invincible_mode := false
var enemy_invincible_mode := false
var resolving_hit_effects := false
var level_up_fx_time := 99.0
var test_menu_open := true
var test_weapon_panel_open := false
var test_weapon_only_mode := false
var test_weapon_selected_id := ""
var next_enemy_id := 1

var stash := {
	"gold": 0,
	"relics": 0,
	"keys": 0,
	"ore": 0,
	"best_value": 0,
	"camp_damage": 0,
	"weapon_slots": INITIAL_WEAPON_SLOTS,
	"charm_slots": INITIAL_CHARM_SLOTS,
}

var stats := {}
var backpack := {}
var enemies: Array[Dictionary] = []
var projectiles: Array[Dictionary] = []
var queued_projectile_shots: Array[Dictionary] = []
var mines: Array[Dictionary] = []
var burn_zones: Array[Dictionary] = []
var nightmare_gates: Array[Dictionary] = []
var storm_tornadoes: Array[Dictionary] = []
var rune_rocks: Array[Dictionary] = []
var loot: Array[Dictionary] = []
var interactables: Array[Dictionary] = []
var opened_chests: Array[Dictionary] = []
var effects: Array[Dictionary] = []
var beams: Array[Dictionary] = []
var offered_upgrades: Array[Dictionary] = []
var weapon_levels := {}
var charm_levels := {}
var evolved_weapons := {}
var weapon_timers := {}
var weapon_stat_bonuses := {}
var weapon_icon_textures := {}
var attack_effect_textures := {}
var charm_icon_textures := {}
var relic_icon_textures := {}
var interactable_textures := {}
var acquired_relics: Array[String] = []
var treasure_counts := {}
var extract_pos := Vector2.ZERO
var player_right_texture: Texture2D
var player_left_texture: Texture2D
var katana_slash_blue_texture: Texture2D
var katana_slash_gold_texture: Texture2D
var flame_step_orange_texture: Texture2D
var flame_step_blue_texture: Texture2D
var flame_trail_texture: Texture2D
var flame_ring_texture: Texture2D
var saint_arrow_texture: Texture2D
var silver_bullet_texture: Texture2D
var homing_dagger_texture: Texture2D
var rune_boomerang_texture: Texture2D
var magic_missile_texture: Texture2D
var trap_rune_texture: Texture2D
var bound_star_texture: Texture2D
var crescent_axe_texture: Texture2D
var fortune_rune_texture: Texture2D
var venom_bottle_texture: Texture2D
var blood_scythe_texture: Texture2D
var blood_scythe_hit_image: Image
var gravity_spike_texture: Texture2D
var lightning_strike_texture: Texture2D
var nightmare_gate_texture: Texture2D
var flame_step_texture: Texture2D
var enemy_ghost_right_texture: Texture2D
var enemy_ghost_left_texture: Texture2D
var enemy_shadow_cat_right_texture: Texture2D
var enemy_shadow_cat_left_texture: Texture2D
var boss_dark_knight_right_texture: Texture2D
var boss_dark_knight_left_texture: Texture2D
var loot_xp_crystal_texture: Texture2D
var loot_coin_texture: Texture2D

@onready var ui := CanvasLayer.new()
@onready var top_label := Label.new()
@onready var bag_label := Label.new()
@onready var status_label := Label.new()
@onready var extract_button := Button.new()
@onready var interact_button := Button.new()
@onready var minimap_button := Button.new()
@onready var choice_panel := PanelContainer.new()
@onready var chest_reward_panel := PanelContainer.new()
@onready var altar_relic_panel := PanelContainer.new()
@onready var merchant_panel := PanelContainer.new()
@onready var result_panel := PanelContainer.new()
@onready var start_panel := PanelContainer.new()
@onready var test_panel := PanelContainer.new()
@onready var test_weapon_panel := PanelContainer.new()
@onready var test_toggle_button := Button.new()


func _ready() -> void:
	rng.randomize()
	texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	_load_player_textures()
	load_stash()
	add_child(ui)
	_setup_ui()
	show_start()


func _load_black_transparent_texture(path: String) -> Texture2D:
	var img: Image = null
	var tex := load(path) as Texture2D
	if tex != null:
		img = tex.get_image()
	if img == null:
		var global_path := ProjectSettings.globalize_path(path)
		img = Image.load_from_file(global_path)
	if img == null:
		printerr("Failed to load image for black transparent conversion: ", path)
		return null
	img.convert(Image.FORMAT_RGBA8)
	for y in img.get_height():
		for x in img.get_width():
			var color := img.get_pixel(x, y)
			var brightness := color.r * 0.299 + color.g * 0.587 + color.b * 0.114
			color.a = clampf(brightness * 2.2, 0.0, 1.0)
			img.set_pixel(x, y, color)
	return ImageTexture.create_from_image(img)


func _load_image_texture(path: String) -> Texture2D:
	var img := Image.load_from_file(ProjectSettings.globalize_path(path))
	if img != null:
		img.convert(Image.FORMAT_RGBA8)
		return ImageTexture.create_from_image(img)
	var tex := load(path) as Texture2D
	if tex != null:
		return tex
	printerr("Failed to load image: ", path)
	return null


func _load_player_textures() -> void:
	player_right_texture = load(PLAYER_RIGHT_PATH) as Texture2D
	player_left_texture = load(PLAYER_LEFT_PATH) as Texture2D
	katana_slash_blue_texture = _load_black_transparent_texture(KATANA_SLASH_BLUE_PATH)
	katana_slash_gold_texture = _load_black_transparent_texture(KATANA_SLASH_GOLD_PATH)
	flame_step_orange_texture = _load_black_transparent_texture(FLAME_STEP_ORANGE_PATH)
	flame_step_blue_texture = _load_black_transparent_texture(FLAME_STEP_BLUE_PATH)
	saint_arrow_texture = load(SAINT_ARROW_PATH) as Texture2D
	silver_bullet_texture = _load_image_texture(SILVER_BULLET_PATH)
	homing_dagger_texture = load(HOMING_DAGGER_PATH) as Texture2D
	rune_boomerang_texture = load(RUNE_BOOMERANG_PATH) as Texture2D
	magic_missile_texture = load(MAGIC_MISSILE_PATH) as Texture2D
	trap_rune_texture = load(TRAP_RUNE_PATH) as Texture2D
	bound_star_texture = load(BOUND_STAR_PATH) as Texture2D
	crescent_axe_texture = load(CRESCENT_AXE_PATH) as Texture2D
	fortune_rune_texture = load(FORTUNE_RUNE_PATH) as Texture2D
	venom_bottle_texture = load(VENOM_BOTTLE_PATH) as Texture2D
	blood_scythe_texture = _load_image_texture(BLOOD_SCYTHE_PATH)
	blood_scythe_hit_image = Image.load_from_file(ProjectSettings.globalize_path(BLOOD_SCYTHE_PATH))
	if blood_scythe_hit_image != null:
		blood_scythe_hit_image.convert(Image.FORMAT_RGBA8)
	gravity_spike_texture = _load_image_texture(GRAVITY_SPIKE_SPEAR_PATH)
	flame_step_texture = load(FLAME_STEP_EFFECT_PATH) as Texture2D
	flame_trail_texture = _load_image_texture(FLAME_TRAIL_EFFECT_PATH)
	flame_ring_texture = _load_image_texture(FLAME_RING_EFFECT_PATH)
	lightning_strike_texture = _load_image_texture(LIGHTNING_STRIKE_PATH)
	nightmare_gate_texture = _load_image_texture(NIGHTMARE_GATE_PATH)
	_load_attack_effect_textures()
	_load_weapon_icon_textures()
	_load_charm_icon_textures()
	_load_relic_icon_textures()
	_load_interactable_textures()
	enemy_ghost_right_texture = load(ENEMY_GHOST_RIGHT_PATH) as Texture2D
	enemy_ghost_left_texture = load(ENEMY_GHOST_LEFT_PATH) as Texture2D
	enemy_shadow_cat_right_texture = load(ENEMY_SHADOW_CAT_RIGHT_PATH) as Texture2D
	enemy_shadow_cat_left_texture = load(ENEMY_SHADOW_CAT_LEFT_PATH) as Texture2D
	boss_dark_knight_right_texture = load(BOSS_DARK_KNIGHT_RIGHT_PATH) as Texture2D
	boss_dark_knight_left_texture = load(BOSS_DARK_KNIGHT_LEFT_PATH) as Texture2D
	loot_xp_crystal_texture = load(LOOT_XP_CRYSTAL_PATH) as Texture2D
	loot_coin_texture = load(LOOT_COIN_PATH) as Texture2D


func _load_weapon_icon_textures() -> void:
	weapon_icon_textures.clear()
	for weapon_id in WEAPON_ICON_PATHS.keys():
		var path := String(WEAPON_ICON_PATHS[weapon_id])
		var texture: Texture2D = load(path) as Texture2D
		if texture == null:
			texture = _load_image_texture(path)
		weapon_icon_textures[String(weapon_id)] = texture


func _load_attack_effect_textures() -> void:
	attack_effect_textures.clear()
	for effect_id in ATTACK_EFFECT_PATHS.keys():
		attack_effect_textures[String(effect_id)] = _load_image_texture(String(ATTACK_EFFECT_PATHS[effect_id]))


func _load_charm_icon_textures() -> void:
	charm_icon_textures.clear()
	for charm_id in CHARM_ICON_PATHS.keys():
		charm_icon_textures[String(charm_id)] = load(String(CHARM_ICON_PATHS[charm_id])) as Texture2D


func _load_relic_icon_textures() -> void:
	relic_icon_textures.clear()
	for entry in TREASURE_DEFS:
		var treasure := entry as Dictionary
		var relic_id := String(treasure["id"])
		relic_icon_textures[relic_id] = load("res://assets/relic_icons/%s.png" % relic_id) as Texture2D


func _load_interactable_textures() -> void:
	interactable_textures.clear()
	for kind in INTERACTABLE_TEXTURE_PATHS.keys():
		var path := String(INTERACTABLE_TEXTURE_PATHS[kind])
		var texture := load(path) as Texture2D
		if texture == null:
			texture = _load_image_texture(path)
		interactable_textures[String(kind)] = texture


func _process(delta: float) -> void:
	if not started:
		minimap_button.visible = false
		queue_redraw()
		return

	level_up_fx_time += delta
	if chest_reward_open:
		chest_reward_time += delta
	if altar_relic_choice_open:
		altar_relic_choice_time += delta
	if merchant_choice_open:
		merchant_choice_time += delta
	_update_xp_bar_display(delta)
	_update_opened_chests(delta)
	_update_minimap_button(get_viewport_rect().size)
	if run_over or choice_open:
		_update_effects(delta)
		_update_beams(delta)
		queue_redraw()
		return

	elapsed += delta
	attack_timer -= delta
	spawn_timer -= delta
	elite_timer -= delta
	lightning_timer -= delta
	mine_timer -= delta
	event_timer -= delta
	drone_angle += delta * 2.8
	dash_cooldown = max(0.0, dash_cooldown - delta)
	shield_recharge_timer = max(0.0, shield_recharge_timer - delta)
	_update_passive_recovery(delta)

	var size := get_viewport_rect().size
	_handle_movement(delta, size)
	_handle_dash()

	if spawn_timer <= 0.0:
		if not test_mode:
			_spawn_enemy(size, false)
		spawn_timer = max(0.16, 0.82 - elapsed / 280.0 - float(stats.get("difficulty", 0.0)) * 0.18)

	if elite_timer <= 0.0 and not test_mode:
		_spawn_enemy(size, true)
		elite_timer = max(13.0, 24.0 - elapsed / 22.0)

	if not test_mode and not boss_spawned and elapsed >= BOSS_TIME:
		_spawn_boss(size)
		boss_spawned = true

	if event_timer <= 0.0 and not test_mode:
		_spawn_map_event(size)
		event_timer = rng.randf_range(18.0, 26.0)

	if attack_timer <= 0.0:
		if _should_fire_base_attack():
			_fire_at_nearest_enemy()
		attack_timer = max(0.1, float(stats["attack_rate"]))

	_update_auto_combat_weapons(delta)
	_update_aura_damage(delta)
	if test_weapon_only_mode and int(weapon_levels.get(test_weapon_selected_id, 0)) <= 0:
		_clear_test_weapon_combat_artifacts()

	if EXTRACTION_ENABLED and not extract_open and (kills >= EXTRACTION_KILL_TARGET or elapsed >= EXTRACTION_TIME):
		_open_extraction(size)

	_update_projectiles(delta)
	_update_mines(delta)
	_update_burn_zones(delta)
	_update_storm_tornadoes(delta)
	_update_rune_rocks(delta)
	_update_enemies(delta, size)
	_update_nightmare_gates(delta)
	_update_loot(delta)
	_update_reward_chests()
	_update_touch_interactables()
	_update_effects(delta)
	_update_beams(delta)
	_update_queued_projectile_shots(delta)
	_update_interaction_ui()
	_update_ui()
	queue_redraw()


func _unhandled_input(event: InputEvent) -> void:
	if not started:
		return
	if event is InputEventScreenTouch:
		touch_active = event.pressed
		target_pos = _screen_to_world(event.position)
	elif event is InputEventScreenDrag:
		touch_active = true
		target_pos = _screen_to_world(event.position)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		touch_active = event.pressed
		target_pos = _screen_to_world(event.position)
	elif event is InputEventMouseMotion and touch_active:
		target_pos = _screen_to_world(event.position)

	if EXTRACTION_ENABLED and Input.is_action_just_pressed("extract") and not choice_open and not run_over:
		if _nearest_interactable() >= 0:
			_interact_nearby()


func _draw() -> void:
	var size := get_viewport_rect().size
	_draw_background(size)
	draw_set_transform(-camera_pos)
	if EXTRACTION_ENABLED and extract_open:
		_draw_extraction()
	for zone in burn_zones:
		_draw_burn_zone(zone)
	for interactable in interactables:
		_draw_interactable(interactable)
	for chest in opened_chests:
		_draw_opened_chest(chest)
	for item in loot:
		_draw_loot(item)
	for mine in mines:
		_draw_mine(mine)
	for beam in beams:
		_draw_beam(beam)
	for projectile in projectiles:
		_draw_projectile(projectile)
	for rock in rune_rocks:
		_draw_rune_rock(rock)
	for enemy in enemies:
		_draw_enemy(enemy)
	_draw_drones()
	for effect in effects:
		_draw_effect(effect)
	_draw_active_auras()
	_draw_player()
	_draw_aegis_shield()
	draw_set_transform(Vector2.ZERO)
	if choice_open:
		if chest_reward_open:
			_draw_chest_reward_backdrop(size)
		elif altar_relic_choice_open:
			_draw_altar_relic_backdrop(size)
		elif merchant_choice_open:
			_draw_merchant_backdrop(size)
		else:
			_draw_level_up_backdrop(size)
	_draw_hud_xp_bar(size)
	if not choice_open:
		if minimap_open:
			_draw_minimap(size)
		_draw_relic_hud(size)


func show_start() -> void:
	started = false
	choice_open = false
	start_panel.visible = true
	result_panel.visible = false
	choice_panel.visible = false
	chest_reward_panel.visible = false
	altar_relic_panel.visible = false
	merchant_panel.visible = false
	extract_button.visible = false
	interact_button.visible = false
	minimap_open = false
	minimap_button.visible = false
	minimap_button.text = "地図"
	chest_reward_open = false
	altar_relic_choice_open = false
	merchant_choice_open = false
	pending_chest_reward.clear()
	offered_altar_relics.clear()
	offered_merchant_relics.clear()
	test_mode = false
	test_menu_open = false
	test_weapon_panel_open = false
	test_weapon_only_mode = false
	enemy_invincible_mode = false
	_update_test_menu_visibility()
	_update_ui()


func start_run(test_stage: bool = false) -> void:
	var size := get_viewport_rect().size
	started = true
	run_over = false
	choice_open = false
	chest_reward_open = false
	chest_reward_panel.visible = false
	pending_chest_reward.clear()
	altar_relic_choice_open = false
	altar_relic_panel.visible = false
	offered_altar_relics.clear()
	merchant_choice_open = false
	merchant_panel.visible = false
	offered_merchant_relics.clear()
	merchant_choice_index = -1
	merchant_purchase_count = 0
	chest_open_count = 0
	minimap_open = false
	minimap_button.text = "地図"
	test_mode = test_stage
	test_weapon_index = 0
	test_weapon_panel_open = false
	test_weapon_only_mode = false
	test_weapon_selected_id = ""
	invincible_mode = test_stage
	enemy_invincible_mode = false
	player_pos = WORLD_SIZE * Vector2(0.5, 0.5)
	target_pos = player_pos
	_update_camera(size)
	player_hp = max_hp
	player_level = 1
	xp = 0
	xp_next = 10
	displayed_xp_ratio = 0.0
	kills = 0
	elapsed = 0.0
	attack_timer = 0.0
	regen_timer = 0.0
	shield_recharge_timer = 0.0
	player_shield = 0
	next_enemy_id = 1
	spawn_timer = 0.2
	elite_timer = 16.0
	lightning_timer = 0.6
	mine_timer = 1.0
	event_timer = 5.0
	drone_angle = 0.0
	dash_cooldown = 0.0
	extract_open = false
	boss_spawned = false
	backpack = {
		"gold": 0,
		"relics": 0,
		"keys": 0,
		"ore": 0,
	}
	stats = {
		"damage": 7,
		"attack_rate": BASE_ATTACK_RATE,
		"range": BASE_ATTACK_RANGE,
		"projectiles": 1,
		"magnet": 84.0,
		"armor": 0,
		"speed": BASE_PLAYER_SPEED,
		"drone_count": 0,
		"drone_damage": 5,
		"drone_radius": 112.0,
		"lightning_targets": 0,
		"lightning_damage": 18,
		"lightning_rate": 3.8,
		"mine_damage": 0,
		"mine_rate": 0.0,
		"curse_power": 0,
		"xp_gain": 1.0,
		"gold_gain": 1.0,
		"luck": 0.0,
		"evasion": 0.0,
		"frost_chance": 0.0,
			"boss_damage": 1.0,
			"crit_chance": 0.0,
			"crit_damage": 1.75,
			"projectile_speed": 1.0,
		"area_size": 1.0,
		"skill_cooldown": 1.0,
		"thorns": 0,
		"lifesteal_chance": 0.0,
		"shield": 0,
		"difficulty": 0.0,
		"regen": 0.0,
		"duration": 1.0,
		"knockback": 1.0,
		"poison_chance": 0.0,
		"low_hp_damage": 0.0,
		"near_damage": 0.0,
		"bonk_chance": 0.0,
		"execute_chance": 0.0,
		"explode_chance": 0.0,
		"lightning_chance": 0.0,
		"burger_chance": 0.0,
		"bonus_xp_chance": 0.0,
		"kill_damage_gain": 0.0,
		"key_open_chance": 0.0,
	}
	weapon_levels = {}
	charm_levels = {}
	evolved_weapons = {}
	weapon_timers = {}
	acquired_relics = []
	treasure_counts = {}
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		var weapon_id := String(def["id"])
		weapon_levels[weapon_id] = 0
		weapon_timers[weapon_id] = 0.0
	enemies.clear()
	projectiles.clear()
	queued_projectile_shots.clear()
	mines.clear()
	burn_zones.clear()
	nightmare_gates.clear()
	storm_tornadoes.clear()
	rune_rocks.clear()
	loot.clear()
	interactables.clear()
	opened_chests.clear()
	effects.clear()
	beams.clear()
	if test_mode:
		_setup_test_stage()
	else:
		_spawn_start_events(size)
	start_panel.visible = false
	result_panel.visible = false
	choice_panel.visible = false
	chest_reward_panel.visible = false
	chest_reward_open = false
	pending_chest_reward.clear()
	altar_relic_panel.visible = false
	altar_relic_choice_open = false
	offered_altar_relics.clear()
	merchant_panel.visible = false
	merchant_choice_open = false
	offered_merchant_relics.clear()
	merchant_choice_index = -1
	interact_button.visible = false
	test_menu_open = true
	_update_test_menu_visibility()
	_update_ui()
	queue_redraw()


func _setup_ui() -> void:
	for label in [top_label, bag_label, status_label]:
		label.add_theme_font_size_override("font_size", 24)
		label.add_theme_color_override("font_color", Color(0.94, 0.92, 0.86))
		label.add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.55))
		label.add_theme_constant_override("shadow_offset_x", 2)
		label.add_theme_constant_override("shadow_offset_y", 2)
		ui.add_child(label)

	top_label.position = Vector2(22, 30)
	bag_label.position = Vector2(22, 68)
	status_label.position = Vector2(22, 106)

	test_toggle_button.text = "TEST"
	test_toggle_button.visible = false
	test_toggle_button.position = Vector2(614, 112)
	test_toggle_button.custom_minimum_size = Vector2(86, 42)
	test_toggle_button.add_theme_font_size_override("font_size", 16)
	test_toggle_button.pressed.connect(_toggle_test_menu)
	ui.add_child(test_toggle_button)

	extract_button.text = "脱出"
	extract_button.visible = false
	extract_button.position = Vector2(500, 1100)
	extract_button.custom_minimum_size = Vector2(170, 76)
	extract_button.add_theme_font_size_override("font_size", 26)
	extract_button.pressed.connect(_try_extract)
	ui.add_child(extract_button)

	interact_button.text = "調べる"
	interact_button.visible = false
	interact_button.position = Vector2(470, 1010)
	interact_button.custom_minimum_size = Vector2(200, 70)
	interact_button.add_theme_font_size_override("font_size", 24)
	interact_button.pressed.connect(_interact_nearby)
	ui.add_child(interact_button)

	minimap_button.text = "地図"
	minimap_button.visible = false
	minimap_button.custom_minimum_size = Vector2(74, 48)
	minimap_button.add_theme_font_size_override("font_size", 18)
	minimap_button.add_theme_stylebox_override("normal", _panel_style(Color(0.025, 0.03, 0.04, 0.86), Color(0.56, 0.66, 0.78, 0.92), 2, 1, 10.0))
	minimap_button.add_theme_stylebox_override("hover", _panel_style(Color(0.04, 0.055, 0.075, 0.94), Color(0.92, 0.84, 0.46, 1.0), 2, 1, 10.0))
	minimap_button.add_theme_stylebox_override("pressed", _panel_style(Color(0.02, 0.02, 0.028, 0.96), Color(0.42, 0.9, 1.0, 1.0), 2, 1, 10.0))
	minimap_button.pressed.connect(_toggle_minimap)
	ui.add_child(minimap_button)

	_setup_start_panel()
	_setup_choice_panel()
	_setup_chest_reward_panel()
	_setup_altar_relic_panel()
	_setup_merchant_panel()
	_setup_result_panel()
	_setup_test_panel()
	_setup_test_weapon_panel()


func _toggle_minimap() -> void:
	minimap_open = not minimap_open
	minimap_button.text = "閉じる" if minimap_open else "地図"
	queue_redraw()


func _update_minimap_button(size: Vector2) -> void:
	minimap_button.visible = started and not run_over and not choice_open
	minimap_button.position = Vector2(size.x - minimap_button.custom_minimum_size.x - 18.0, 24.0)


func _toggle_test_menu() -> void:
	if not test_mode:
		return
	test_menu_open = not test_menu_open
	_update_test_menu_visibility()


func _update_test_menu_visibility() -> void:
	test_toggle_button.visible = test_mode
	test_panel.visible = test_mode and test_menu_open
	test_weapon_panel.visible = test_mode and test_weapon_panel_open
	test_toggle_button.text = "TEST -" if test_menu_open else "TEST +"


func _panel_style(bg: Color, border: Color, border_width: int = 2, radius: int = 3, content_margin: float = 0.0) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = bg
	style.border_color = border
	style.set_border_width_all(border_width)
	style.set_corner_radius_all(radius)
	if content_margin > 0.0:
		style.set_content_margin(SIDE_LEFT, content_margin)
		style.set_content_margin(SIDE_RIGHT, content_margin)
		style.set_content_margin(SIDE_TOP, content_margin)
		style.set_content_margin(SIDE_BOTTOM, content_margin)
	style.shadow_color = Color(0.0, 0.0, 0.0, 0.38)
	style.shadow_size = 5
	style.shadow_offset = Vector2(0.0, 3.0)
	return style


func _setup_start_panel() -> void:
	start_panel.position = Vector2(56, 340)
	start_panel.custom_minimum_size = Vector2(608, 430)
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 16)

	var title := Label.new()
	title.text = "Godot Auto Combat Kit"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 48)
	box.add_child(title)

	var body := Label.new()
	body.text = "自動攻撃で敵を倒し、武器とチャームを育てる。\nラン中のビルドを伸ばしてボス撃破を狙う。"
	body.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	body.add_theme_font_size_override("font_size", 24)
	box.add_child(body)

	var stash_label := Label.new()
	stash_label.name = "Stash"
	stash_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	stash_label.add_theme_font_size_override("font_size", 22)
	box.add_child(stash_label)

	var start_button := Button.new()
	start_button.text = "ダンジョンへ"
	start_button.custom_minimum_size = Vector2(430, 76)
	start_button.add_theme_font_size_override("font_size", 30)
	start_button.pressed.connect(start_run)
	box.add_child(start_button)

	var test_button := Button.new()
	test_button.text = "テスト場"
	test_button.custom_minimum_size = Vector2(430, 66)
	test_button.add_theme_font_size_override("font_size", 26)
	test_button.pressed.connect(start_run.bind(true))
	box.add_child(test_button)

	start_panel.add_child(box)
	ui.add_child(start_panel)


func _setup_choice_panel() -> void:
	choice_panel.visible = false
	choice_panel.position = Vector2(12, 250)
	choice_panel.custom_minimum_size = Vector2(696, 620)
	choice_panel.size = choice_panel.custom_minimum_size
	choice_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.012, 0.014, 0.014, 0.96), Color(0.56, 0.62, 0.58, 0.95), 3, 2, 24.0))
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 20)

	var title := Label.new()
	title.name = "Title"
	title.text = "レベルアップ！"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	title.custom_minimum_size = Vector2(648, 34)
	title.add_theme_font_size_override("font_size", 21)
	title.add_theme_color_override("font_color", Color(0.96, 0.98, 0.92))
	box.add_child(title)

	var subtitle := Label.new()
	subtitle.name = "Subtitle"
	subtitle.text = ""
	subtitle.visible = false
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_font_size_override("font_size", 20)
	subtitle.add_theme_color_override("font_color", Color(0.78, 1.0, 0.82))
	box.add_child(subtitle)

	for i in 3:
		var button := Button.new()
		button.name = "Upgrade%d" % i
		button.custom_minimum_size = Vector2(648, 132)
		button.add_theme_font_size_override("font_size", 20)
		button.add_theme_constant_override("icon_margin", 12)
		button.add_theme_constant_override("h_separation", 18)
		button.add_theme_stylebox_override("normal", _panel_style(Color(0.02, 0.16, 0.08, 0.95), Color(0.64, 0.78, 0.68, 0.95), 2, 2))
		button.add_theme_stylebox_override("hover", _panel_style(Color(0.04, 0.26, 0.12, 0.98), Color(0.98, 0.9, 0.34, 1.0), 3, 2))
		button.add_theme_stylebox_override("pressed", _panel_style(Color(0.03, 0.12, 0.08, 0.98), Color(0.38, 1.0, 0.58, 1.0), 3, 2))
		button.add_theme_color_override("font_color", Color(0.95, 0.96, 0.9))
		button.icon_alignment = HORIZONTAL_ALIGNMENT_LEFT
		button.expand_icon = false
		button.pressed.connect(_choose_upgrade.bind(i))
		_setup_upgrade_card_button(button)
		box.add_child(button)

	choice_panel.add_child(box)
	ui.add_child(choice_panel)


func _setup_upgrade_card_button(button: Button) -> void:
	button.text = ""
	button.icon = null
	var margin := MarginContainer.new()
	margin.name = "Card"
	margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 18)
	margin.add_theme_constant_override("margin_right", 18)
	margin.add_theme_constant_override("margin_top", 12)
	margin.add_theme_constant_override("margin_bottom", 12)

	var row := HBoxContainer.new()
	row.name = "Row"
	row.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_theme_constant_override("separation", 16)
	margin.add_child(row)

	var left := VBoxContainer.new()
	left.name = "IconColumn"
	left.mouse_filter = Control.MOUSE_FILTER_IGNORE
	left.custom_minimum_size = Vector2(100, 106)
	left.add_theme_constant_override("separation", 4)
	row.add_child(left)

	var rarity := Label.new()
	rarity.name = "Rarity"
	rarity.mouse_filter = Control.MOUSE_FILTER_IGNORE
	rarity.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	rarity.add_theme_font_size_override("font_size", 17)
	left.add_child(rarity)

	var icon_frame := PanelContainer.new()
	icon_frame.name = "IconFrame"
	icon_frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon_frame.custom_minimum_size = Vector2(80, 78)
	left.add_child(icon_frame)

	var icon_margin := MarginContainer.new()
	icon_margin.name = "IconMargin"
	icon_margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon_margin.add_theme_constant_override("margin_left", 6)
	icon_margin.add_theme_constant_override("margin_right", 6)
	icon_margin.add_theme_constant_override("margin_top", 6)
	icon_margin.add_theme_constant_override("margin_bottom", 6)
	icon_frame.add_child(icon_margin)

	var icon := TextureRect.new()
	icon.name = "Icon"
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.custom_minimum_size = Vector2(64, 64)
	icon_margin.add_child(icon)

	var right := VBoxContainer.new()
	right.name = "TextColumn"
	right.mouse_filter = Control.MOUSE_FILTER_IGNORE
	right.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	right.add_theme_constant_override("separation", 5)
	row.add_child(right)

	var header := HBoxContainer.new()
	header.name = "Header"
	header.mouse_filter = Control.MOUSE_FILTER_IGNORE
	header.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_theme_constant_override("separation", 8)
	right.add_child(header)

	var name_label := Label.new()
	name_label.name = "Name"
	name_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_label.add_theme_font_size_override("font_size", 22)
	name_label.add_theme_color_override("font_color", Color(0.96, 0.96, 0.88))
	header.add_child(name_label)

	var state_label := Label.new()
	state_label.name = "State"
	state_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	state_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	state_label.custom_minimum_size = Vector2(96, 26)
	state_label.add_theme_font_size_override("font_size", 18)
	state_label.add_theme_color_override("font_color", Color(1.0, 0.92, 0.42))
	header.add_child(state_label)

	var effect := RichTextLabel.new()
	effect.name = "Effect"
	effect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	effect.bbcode_enabled = true
	effect.fit_content = true
	effect.scroll_active = false
	effect.custom_minimum_size = Vector2(452, 48)
	effect.add_theme_font_size_override("normal_font_size", 18)
	right.add_child(effect)

	button.add_child(margin)


func _setup_chest_reward_panel() -> void:
	chest_reward_panel.visible = false
	chest_reward_panel.position = Vector2(62, 270)
	chest_reward_panel.custom_minimum_size = Vector2(596, 560)
	chest_reward_panel.size = chest_reward_panel.custom_minimum_size
	chest_reward_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.006, 0.026, 0.030, 0.98), Color(0.66, 0.74, 0.68, 0.96), 3, 2, 22.0))

	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 14)
	chest_reward_panel.add_child(box)

	var rarity := Label.new()
	rarity.name = "Rarity"
	rarity.text = "RELIC"
	rarity.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	rarity.custom_minimum_size = Vector2(552, 34)
	rarity.add_theme_font_size_override("font_size", 29)
	box.add_child(rarity)

	var title := Label.new()
	title.name = "Title"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.custom_minimum_size = Vector2(552, 38)
	title.add_theme_font_size_override("font_size", 31)
	title.add_theme_color_override("font_color", Color(1.0, 0.96, 0.78))
	box.add_child(title)

	var desc := Label.new()
	desc.name = "Desc"
	desc.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc.custom_minimum_size = Vector2(552, 72)
	desc.add_theme_font_size_override("font_size", 18)
	desc.add_theme_color_override("font_color", Color(0.92, 0.96, 0.90))
	box.add_child(desc)

	var stage := Control.new()
	stage.name = "Stage"
	stage.custom_minimum_size = Vector2(552, 250)
	box.add_child(stage)

	var chest_icon := TextureRect.new()
	chest_icon.name = "ChestIcon"
	chest_icon.position = Vector2(199, 123)
	chest_icon.custom_minimum_size = Vector2(154, 112)
	chest_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	chest_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	stage.add_child(chest_icon)

	var relic_frame := PanelContainer.new()
	relic_frame.name = "RelicFrame"
	relic_frame.position = Vector2(202, 18)
	relic_frame.custom_minimum_size = Vector2(148, 148)
	stage.add_child(relic_frame)

	var relic_margin := MarginContainer.new()
	relic_margin.name = "RelicMargin"
	relic_margin.add_theme_constant_override("margin_left", 12)
	relic_margin.add_theme_constant_override("margin_right", 12)
	relic_margin.add_theme_constant_override("margin_top", 12)
	relic_margin.add_theme_constant_override("margin_bottom", 12)
	relic_frame.add_child(relic_margin)

	var relic_icon := TextureRect.new()
	relic_icon.name = "RelicIcon"
	relic_icon.custom_minimum_size = Vector2(124, 124)
	relic_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	relic_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	relic_margin.add_child(relic_icon)

	var take := Button.new()
	take.name = "Take"
	take.text = "取得"
	take.custom_minimum_size = Vector2(240, 62)
	take.add_theme_font_size_override("font_size", 25)
	take.pressed.connect(_take_chest_reward)
	box.add_child(take)

	ui.add_child(chest_reward_panel)


func _setup_altar_relic_panel() -> void:
	altar_relic_panel.visible = false
	altar_relic_panel.position = Vector2(26, 238)
	altar_relic_panel.custom_minimum_size = Vector2(668, 690)
	altar_relic_panel.size = altar_relic_panel.custom_minimum_size
	altar_relic_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.018, 0.008, 0.028, 0.97), Color(0.72, 0.36, 1.0, 0.96), 3, 2, 22.0))

	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 16)
	altar_relic_panel.add_child(box)

	var title := Label.new()
	title.name = "Title"
	title.text = "祭壇の贈り物"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.custom_minimum_size = Vector2(624, 36)
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color(1.0, 0.88, 1.0))
	box.add_child(title)

	var subtitle := Label.new()
	subtitle.name = "Subtitle"
	subtitle.text = "1つ選んで無料で獲得"
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_font_size_override("font_size", 18)
	subtitle.add_theme_color_override("font_color", Color(0.88, 0.78, 1.0))
	box.add_child(subtitle)

	for i in 3:
		var button := Button.new()
		button.name = "Relic%d" % i
		button.text = ""
		button.custom_minimum_size = Vector2(624, 160)
		button.add_theme_font_size_override("font_size", 18)
		button.pressed.connect(_choose_altar_relic.bind(i))
		_setup_altar_relic_button(button)
		box.add_child(button)

	ui.add_child(altar_relic_panel)


func _setup_altar_relic_button(button: Button) -> void:
	var margin := MarginContainer.new()
	margin.name = "Card"
	margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 18)
	margin.add_theme_constant_override("margin_right", 18)
	margin.add_theme_constant_override("margin_top", 12)
	margin.add_theme_constant_override("margin_bottom", 12)
	button.add_child(margin)

	var row := HBoxContainer.new()
	row.name = "Row"
	row.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_theme_constant_override("separation", 16)
	margin.add_child(row)

	var icon_frame := PanelContainer.new()
	icon_frame.name = "IconFrame"
	icon_frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon_frame.custom_minimum_size = Vector2(104, 104)
	row.add_child(icon_frame)

	var icon_margin := MarginContainer.new()
	icon_margin.name = "IconMargin"
	icon_margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon_margin.add_theme_constant_override("margin_left", 8)
	icon_margin.add_theme_constant_override("margin_right", 8)
	icon_margin.add_theme_constant_override("margin_top", 8)
	icon_margin.add_theme_constant_override("margin_bottom", 8)
	icon_frame.add_child(icon_margin)

	var icon := TextureRect.new()
	icon.name = "Icon"
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.custom_minimum_size = Vector2(88, 88)
	icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon_margin.add_child(icon)

	var text_col := VBoxContainer.new()
	text_col.name = "TextColumn"
	text_col.mouse_filter = Control.MOUSE_FILTER_IGNORE
	text_col.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_col.add_theme_constant_override("separation", 6)
	row.add_child(text_col)

	var header := HBoxContainer.new()
	header.name = "Header"
	header.mouse_filter = Control.MOUSE_FILTER_IGNORE
	header.add_theme_constant_override("separation", 8)
	text_col.add_child(header)

	var name_label := Label.new()
	name_label.name = "Name"
	name_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_label.add_theme_font_size_override("font_size", 23)
	name_label.add_theme_color_override("font_color", Color(1.0, 0.96, 0.78))
	header.add_child(name_label)

	var rarity_label := Label.new()
	rarity_label.name = "Rarity"
	rarity_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	rarity_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	rarity_label.custom_minimum_size = Vector2(112, 28)
	rarity_label.add_theme_font_size_override("font_size", 18)
	header.add_child(rarity_label)

	var desc := Label.new()
	desc.name = "Desc"
	desc.mouse_filter = Control.MOUSE_FILTER_IGNORE
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc.custom_minimum_size = Vector2(430, 62)
	desc.add_theme_font_size_override("font_size", 17)
	desc.add_theme_color_override("font_color", Color(0.92, 0.94, 0.90))
	text_col.add_child(desc)


func _setup_merchant_panel() -> void:
	merchant_panel.visible = false
	merchant_panel.position = Vector2(26, 238)
	merchant_panel.custom_minimum_size = Vector2(668, 710)
	merchant_panel.size = merchant_panel.custom_minimum_size
	merchant_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.020, 0.014, 0.010, 0.97), Color(1.0, 0.70, 0.24, 0.96), 3, 2, 22.0))

	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 16)
	merchant_panel.add_child(box)

	var title := Label.new()
	title.name = "Title"
	title.text = "商人"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.custom_minimum_size = Vector2(624, 36)
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color(1.0, 0.90, 0.64))
	box.add_child(title)

	var subtitle := Label.new()
	subtitle.name = "Subtitle"
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_font_size_override("font_size", 18)
	subtitle.add_theme_color_override("font_color", Color(1.0, 0.82, 0.44))
	box.add_child(subtitle)

	for i in 3:
		var button := Button.new()
		button.name = "Relic%d" % i
		button.text = ""
		button.custom_minimum_size = Vector2(624, 160)
		button.add_theme_font_size_override("font_size", 18)
		button.pressed.connect(_choose_merchant_relic.bind(i))
		_setup_merchant_relic_button(button)
		box.add_child(button)

	ui.add_child(merchant_panel)


func _setup_merchant_relic_button(button: Button) -> void:
	_setup_altar_relic_button(button)
	var row := button.get_node("Card/Row") as HBoxContainer
	var price_label := Label.new()
	price_label.name = "Price"
	price_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	price_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	price_label.custom_minimum_size = Vector2(92, 104)
	price_label.add_theme_font_size_override("font_size", 21)
	price_label.add_theme_color_override("font_color", Color(1.0, 0.82, 0.24))
	row.add_child(price_label)


func _setup_result_panel() -> void:
	result_panel.visible = false
	result_panel.position = Vector2(56, 360)
	result_panel.custom_minimum_size = Vector2(608, 430)
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 16)

	var title := Label.new()
	title.name = "Title"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 40)
	box.add_child(title)

	var body := Label.new()
	body.name = "Body"
	body.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	body.add_theme_font_size_override("font_size", 23)
	box.add_child(body)

	var camp_button := Button.new()
	camp_button.name = "Camp"
	camp_button.text = "拠点強化: 鉱石8"
	camp_button.visible = false
	camp_button.custom_minimum_size = Vector2(430, 66)
	camp_button.add_theme_font_size_override("font_size", 24)
	camp_button.pressed.connect(_buy_camp_damage)
	box.add_child(camp_button)

	var retry_button := Button.new()
	retry_button.text = "もう一度潜る"
	retry_button.custom_minimum_size = Vector2(430, 76)
	retry_button.add_theme_font_size_override("font_size", 28)
	retry_button.pressed.connect(start_run)
	box.add_child(retry_button)

	result_panel.add_child(box)
	ui.add_child(result_panel)


func _setup_test_panel() -> void:
	test_panel.visible = false
	test_panel.position = Vector2(16, 704)
	test_panel.custom_minimum_size = Vector2(688, 548)
	test_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.02, 0.026, 0.024, 0.94), Color(0.42, 0.72, 0.58, 0.95), 2, 3, 14.0))
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 10)

	var title := Label.new()
	title.text = "TEST PANEL"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 22)
	title.add_theme_color_override("font_color", Color(0.94, 0.98, 0.90))
	box.add_child(title)

	var tabs := TabContainer.new()
	tabs.name = "Tabs"
	tabs.custom_minimum_size = Vector2(660, 474)
	tabs.add_theme_font_size_override("font_size", 17)
	tabs.tab_changed.connect(_test_panel_tab_changed)
	box.add_child(tabs)

	var basic_tab := VBoxContainer.new()
	basic_tab.name = "基本"
	basic_tab.add_theme_constant_override("separation", 12)
	tabs.add_child(basic_tab)

	var quick_grid := GridContainer.new()
	quick_grid.columns = 2
	quick_grid.add_theme_constant_override("h_separation", 10)
	quick_grid.add_theme_constant_override("v_separation", 10)
	basic_tab.add_child(quick_grid)

	var spawn_pack := Button.new()
	spawn_pack.text = "雑魚追加"
	spawn_pack.custom_minimum_size = Vector2(300, 48)
	spawn_pack.add_theme_font_size_override("font_size", 20)
	spawn_pack.pressed.connect(_test_spawn_pack)
	quick_grid.add_child(spawn_pack)

	var spawn_boss := Button.new()
	spawn_boss.text = "ボス追加"
	spawn_boss.custom_minimum_size = Vector2(300, 48)
	spawn_boss.add_theme_font_size_override("font_size", 20)
	spawn_boss.pressed.connect(_test_spawn_boss)
	quick_grid.add_child(spawn_boss)

	var level_up := Button.new()
	level_up.text = "Lv演出/選択"
	level_up.custom_minimum_size = Vector2(300, 48)
	level_up.add_theme_font_size_override("font_size", 20)
	level_up.pressed.connect(_test_open_level_up)
	quick_grid.add_child(level_up)

	var invincible := Button.new()
	invincible.name = "Invincible"
	invincible.text = "無敵: ON"
	invincible.toggle_mode = true
	invincible.button_pressed = true
	invincible.custom_minimum_size = Vector2(300, 48)
	invincible.add_theme_font_size_override("font_size", 20)
	invincible.toggled.connect(_test_toggle_invincible)
	quick_grid.add_child(invincible)

	var enemy_invincible := Button.new()
	enemy_invincible.name = "EnemyInvincible"
	enemy_invincible.text = "敵無敵: OFF"
	enemy_invincible.toggle_mode = true
	enemy_invincible.button_pressed = false
	enemy_invincible.custom_minimum_size = Vector2(300, 48)
	enemy_invincible.add_theme_font_size_override("font_size", 20)
	enemy_invincible.toggled.connect(_test_toggle_enemy_invincible)
	quick_grid.add_child(enemy_invincible)

	var weapon_tab := VBoxContainer.new()
	weapon_tab.name = "武器"
	weapon_tab.add_theme_constant_override("separation", 10)
	tabs.add_child(weapon_tab)

	var weapon_actions := GridContainer.new()
	weapon_actions.columns = 2
	weapon_actions.add_theme_constant_override("h_separation", 10)
	weapon_actions.add_theme_constant_override("v_separation", 10)
	weapon_tab.add_child(weapon_actions)

	var next_weapon := Button.new()
	next_weapon.text = "武器+1"
	next_weapon.custom_minimum_size = Vector2(300, 46)
	next_weapon.add_theme_font_size_override("font_size", 19)
	next_weapon.pressed.connect(_test_add_next_weapon)
	weapon_actions.add_child(next_weapon)

	var all_weapons := Button.new()
	all_weapons.text = "全武器Lv3"
	all_weapons.custom_minimum_size = Vector2(300, 46)
	all_weapons.add_theme_font_size_override("font_size", 19)
	all_weapons.pressed.connect(_test_all_weapons)
	weapon_actions.add_child(all_weapons)

	var weapon_level_panel := Button.new()
	weapon_level_panel.text = "武器Lv詳細"
	weapon_level_panel.custom_minimum_size = Vector2(300, 46)
	weapon_level_panel.add_theme_font_size_override("font_size", 19)
	weapon_level_panel.pressed.connect(_toggle_test_weapon_panel)
	weapon_actions.add_child(weapon_level_panel)

	var clear_weapons := Button.new()
	clear_weapons.text = "全武器Lv0"
	clear_weapons.custom_minimum_size = Vector2(300, 46)
	clear_weapons.add_theme_font_size_override("font_size", 19)
	clear_weapons.pressed.connect(_test_clear_all_weapons)
	weapon_actions.add_child(clear_weapons)

	var weapon_select := OptionButton.new()
	weapon_select.name = "WeaponSelect"
	weapon_select.custom_minimum_size = Vector2(620, 44)
	weapon_select.add_theme_font_size_override("font_size", 18)
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		var weapon_id := String(def["id"])
		if HIDDEN_WEAPON_IDS.has(weapon_id):
			continue
		weapon_select.add_item(String(def["title"]))
		weapon_select.set_item_metadata(weapon_select.item_count - 1, weapon_id)
	weapon_select.item_selected.connect(_test_weapon_option_selected)
	weapon_tab.add_child(weapon_select)

	var add_weapon := Button.new()
	add_weapon.text = "選択武器+1"
	add_weapon.custom_minimum_size = Vector2(620, 46)
	add_weapon.add_theme_font_size_override("font_size", 19)
	add_weapon.pressed.connect(_test_grant_selected_weapon)
	weapon_tab.add_child(add_weapon)

	var preview := PanelContainer.new()
	preview.name = "WeaponPreview"
	preview.custom_minimum_size = Vector2(620, 198)
	preview.add_theme_stylebox_override("panel", _panel_style(Color(0.012, 0.018, 0.016, 0.92), Color(0.36, 0.58, 0.48, 0.9), 2, 3, 10.0))
	weapon_tab.add_child(preview)

	var preview_box := VBoxContainer.new()
	preview_box.add_theme_constant_override("separation", 8)
	preview.add_child(preview_box)

	var preview_title := Label.new()
	preview_title.name = "Title"
	preview_title.text = "武器プレビュー"
	preview_title.add_theme_font_size_override("font_size", 18)
	preview_title.add_theme_color_override("font_color", Color(0.92, 0.98, 0.90))
	preview_box.add_child(preview_title)

	var preview_row := HBoxContainer.new()
	preview_row.add_theme_constant_override("separation", 12)
	preview_box.add_child(preview_row)

	var level_col := VBoxContainer.new()
	level_col.custom_minimum_size = Vector2(118, 124)
	level_col.add_theme_constant_override("separation", 4)
	preview_row.add_child(level_col)

	var level_label := Label.new()
	level_label.text = "レベルアップ"
	level_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	level_label.add_theme_font_size_override("font_size", 15)
	level_label.add_theme_color_override("font_color", Color(0.78, 0.94, 1.0))
	level_col.add_child(level_label)

	var level_icon := TextureRect.new()
	level_icon.name = "LevelIcon"
	level_icon.custom_minimum_size = Vector2(86, 86)
	level_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	level_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	level_col.add_child(level_icon)

	var play_col := VBoxContainer.new()
	play_col.custom_minimum_size = Vector2(118, 124)
	play_col.add_theme_constant_override("separation", 4)
	preview_row.add_child(play_col)

	var play_label := Label.new()
	play_label.text = "プレイ画面"
	play_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	play_label.add_theme_font_size_override("font_size", 15)
	play_label.add_theme_color_override("font_color", Color(1.0, 0.92, 0.62))
	play_col.add_child(play_label)

	var play_icon := TextureRect.new()
	play_icon.name = "PlayIcon"
	play_icon.custom_minimum_size = Vector2(86, 86)
	play_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	play_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	play_col.add_child(play_icon)

	var text_col := VBoxContainer.new()
	text_col.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_col.add_theme_constant_override("separation", 5)
	preview_row.add_child(text_col)

	var name_label := Label.new()
	name_label.name = "Name"
	name_label.add_theme_font_size_override("font_size", 21)
	name_label.add_theme_color_override("font_color", Color(1.0, 0.96, 0.78))
	text_col.add_child(name_label)

	var old_name_label := Label.new()
	old_name_label.name = "OldName"
	old_name_label.add_theme_font_size_override("font_size", 15)
	old_name_label.add_theme_color_override("font_color", Color(0.72, 0.82, 0.78))
	text_col.add_child(old_name_label)

	var level_state := Label.new()
	level_state.name = "Level"
	level_state.add_theme_font_size_override("font_size", 16)
	level_state.add_theme_color_override("font_color", Color(0.66, 1.0, 0.72))
	text_col.add_child(level_state)

	var desc := Label.new()
	desc.name = "Desc"
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc.custom_minimum_size = Vector2(330, 72)
	desc.add_theme_font_size_override("font_size", 16)
	desc.add_theme_color_override("font_color", Color(0.88, 0.94, 0.88))
	text_col.add_child(desc)

	var enemy_tab := VBoxContainer.new()
	enemy_tab.name = "敵"
	enemy_tab.add_theme_constant_override("separation", 12)
	tabs.add_child(enemy_tab)

	var enemy_grid := GridContainer.new()
	enemy_grid.columns = 2
	enemy_grid.add_theme_constant_override("h_separation", 10)
	enemy_grid.add_theme_constant_override("v_separation", 10)
	enemy_tab.add_child(enemy_grid)

	var spawn_pack_2 := Button.new()
	spawn_pack_2.text = "雑魚追加"
	spawn_pack_2.custom_minimum_size = Vector2(300, 54)
	spawn_pack_2.add_theme_font_size_override("font_size", 20)
	spawn_pack_2.pressed.connect(_test_spawn_pack)
	enemy_grid.add_child(spawn_pack_2)

	var spawn_boss_2 := Button.new()
	spawn_boss_2.text = "ボス追加"
	spawn_boss_2.custom_minimum_size = Vector2(300, 54)
	spawn_boss_2.add_theme_font_size_override("font_size", 20)
	spawn_boss_2.pressed.connect(_test_spawn_boss)
	enemy_grid.add_child(spawn_boss_2)

	var relic_tab := VBoxContainer.new()
	relic_tab.name = "レリック"
	relic_tab.add_theme_constant_override("separation", 10)
	tabs.add_child(relic_tab)

	var relic_select := OptionButton.new()
	relic_select.name = "RelicSelect"
	relic_select.custom_minimum_size = Vector2(620, 44)
	relic_select.add_theme_font_size_override("font_size", 18)
	for entry in TREASURE_DEFS:
		var treasure := entry as Dictionary
		relic_select.add_item(String(treasure["title"]))
		relic_select.set_item_metadata(relic_select.item_count - 1, String(treasure["id"]))
	relic_select.item_selected.connect(_test_relic_option_selected)
	relic_tab.add_child(relic_select)

	var relic_preview := PanelContainer.new()
	relic_preview.name = "RelicPreview"
	relic_preview.custom_minimum_size = Vector2(620, 148)
	relic_preview.add_theme_stylebox_override("panel", _panel_style(Color(0.012, 0.018, 0.016, 0.92), Color(0.36, 0.58, 0.48, 0.9), 2, 3, 10.0))
	relic_tab.add_child(relic_preview)

	var relic_preview_row := HBoxContainer.new()
	relic_preview_row.add_theme_constant_override("separation", 14)
	relic_preview.add_child(relic_preview_row)

	var relic_icon := TextureRect.new()
	relic_icon.name = "RelicIcon"
	relic_icon.custom_minimum_size = Vector2(96, 96)
	relic_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	relic_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	relic_preview_row.add_child(relic_icon)

	var relic_text_col := VBoxContainer.new()
	relic_text_col.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	relic_text_col.add_theme_constant_override("separation", 6)
	relic_preview_row.add_child(relic_text_col)

	var relic_name := Label.new()
	relic_name.name = "RelicName"
	relic_name.add_theme_font_size_override("font_size", 21)
	relic_name.add_theme_color_override("font_color", Color(1.0, 0.96, 0.78))
	relic_text_col.add_child(relic_name)

	var relic_rarity := Label.new()
	relic_rarity.name = "RelicRarity"
	relic_rarity.add_theme_font_size_override("font_size", 15)
	relic_rarity.add_theme_color_override("font_color", Color(0.72, 0.86, 0.80))
	relic_text_col.add_child(relic_rarity)

	var relic_desc := Label.new()
	relic_desc.name = "RelicDesc"
	relic_desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	relic_desc.custom_minimum_size = Vector2(460, 62)
	relic_desc.add_theme_font_size_override("font_size", 16)
	relic_desc.add_theme_color_override("font_color", Color(0.88, 0.94, 0.88))
	relic_text_col.add_child(relic_desc)

	var add_relic := Button.new()
	add_relic.text = "選択レリック取得"
	add_relic.custom_minimum_size = Vector2(620, 46)
	add_relic.add_theme_font_size_override("font_size", 19)
	add_relic.pressed.connect(_test_grant_selected_relic)
	relic_tab.add_child(add_relic)

	var item_tab := VBoxContainer.new()
	item_tab.name = "アイテム"
	item_tab.add_theme_constant_override("separation", 10)
	tabs.add_child(item_tab)

	var item_select := OptionButton.new()
	item_select.name = "ItemSelect"
	item_select.custom_minimum_size = Vector2(620, 44)
	item_select.add_theme_font_size_override("font_size", 18)
	var test_items := [
		{"id": "xp", "title": "XP"},
		{"id": "gold", "title": "Gold"},
		{"id": "keys", "title": "Key"},
		{"id": "ore", "title": "Ore"},
		{"id": "relics", "title": "Relic Item"},
		{"id": "meat", "title": "Meat"},
		{"id": "magnet", "title": "Magnet"},
	]
	for item in test_items:
		var item_def := item as Dictionary
		item_select.add_item(String(item_def["title"]))
		item_select.set_item_metadata(item_select.item_count - 1, String(item_def["id"]))
	item_tab.add_child(item_select)

	var add_item := Button.new()
	add_item.text = "選択アイテム出現"
	add_item.custom_minimum_size = Vector2(620, 46)
	add_item.add_theme_font_size_override("font_size", 19)
	add_item.pressed.connect(_test_spawn_selected_item)
	item_tab.add_child(add_item)

	test_panel.add_child(box)
	ui.add_child(test_panel)
	_update_test_weapon_preview()
	_update_test_relic_preview()


func _setup_test_weapon_panel() -> void:
	test_weapon_panel.visible = false
	test_weapon_panel.position = Vector2(34, 260)
	test_weapon_panel.custom_minimum_size = Vector2(652, 720)
	test_weapon_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.012, 0.016, 0.016, 0.94), Color(0.50, 0.76, 0.62, 0.95), 2, 3, 18.0))
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 10)

	var header := HBoxContainer.new()
	header.add_theme_constant_override("separation", 10)
	box.add_child(header)

	var title := Label.new()
	title.text = "武器レベルテスト"
	title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	title.add_theme_font_size_override("font_size", 24)
	title.add_theme_color_override("font_color", Color(0.94, 0.98, 0.90))
	header.add_child(title)

	var close := Button.new()
	close.text = "閉じる"
	close.custom_minimum_size = Vector2(96, 40)
	close.add_theme_font_size_override("font_size", 18)
	close.pressed.connect(_toggle_test_weapon_panel)
	header.add_child(close)

	var body := HBoxContainer.new()
	body.add_theme_constant_override("separation", 14)
	box.add_child(body)

	var list := ItemList.new()
	list.name = "WeaponList"
	list.custom_minimum_size = Vector2(342, 580)
	list.add_theme_font_size_override("font_size", 17)
	list.item_selected.connect(_test_select_weapon_from_list)
	body.add_child(list)

	var detail := VBoxContainer.new()
	detail.name = "Detail"
	detail.custom_minimum_size = Vector2(244, 580)
	detail.add_theme_constant_override("separation", 10)
	body.add_child(detail)

	var icon_frame := PanelContainer.new()
	icon_frame.name = "IconFrame"
	icon_frame.custom_minimum_size = Vector2(124, 124)
	icon_frame.add_theme_stylebox_override("panel", _panel_style(Color(0.02, 0.04, 0.04, 0.95), Color(0.56, 0.70, 0.64), 2, 2, 8.0))
	detail.add_child(icon_frame)

	var icon := TextureRect.new()
	icon.name = "Icon"
	icon.custom_minimum_size = Vector2(108, 108)
	icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon_frame.add_child(icon)

	var name := Label.new()
	name.name = "Name"
	name.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	name.add_theme_font_size_override("font_size", 22)
	name.add_theme_color_override("font_color", Color(1.0, 0.96, 0.78))
	detail.add_child(name)

	var effect := Label.new()
	effect.name = "Effect"
	effect.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	effect.custom_minimum_size = Vector2(230, 72)
	effect.add_theme_font_size_override("font_size", 17)
	effect.add_theme_color_override("font_color", Color(0.90, 0.94, 0.88))
	detail.add_child(effect)

	var level := Label.new()
	level.name = "Level"
	level.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	level.add_theme_font_size_override("font_size", 28)
	level.add_theme_color_override("font_color", Color(0.64, 1.0, 0.70))
	detail.add_child(level)

	var step_row := HBoxContainer.new()
	step_row.add_theme_constant_override("separation", 8)
	detail.add_child(step_row)

	var minus := Button.new()
	minus.text = "-1"
	minus.custom_minimum_size = Vector2(74, 44)
	minus.add_theme_font_size_override("font_size", 20)
	minus.pressed.connect(_test_change_selected_weapon_level.bind(-1))
	step_row.add_child(minus)

	var plus := Button.new()
	plus.text = "+1"
	plus.custom_minimum_size = Vector2(74, 44)
	plus.add_theme_font_size_override("font_size", 20)
	plus.pressed.connect(_test_change_selected_weapon_level.bind(1))
	step_row.add_child(plus)

	var quick := GridContainer.new()
	quick.columns = 3
	quick.add_theme_constant_override("h_separation", 8)
	quick.add_theme_constant_override("v_separation", 8)
	detail.add_child(quick)

	for lv in [0, 1, 3, 5, 10]:
		var button := Button.new()
		button.text = "Lv%d" % int(lv)
		button.custom_minimum_size = Vector2(70, 40)
		button.add_theme_font_size_override("font_size", 18)
		button.pressed.connect(_test_set_selected_weapon_level.bind(int(lv)))
		quick.add_child(button)

	var solo := Button.new()
	solo.text = "単体テスト"
	solo.custom_minimum_size = Vector2(230, 44)
	solo.add_theme_font_size_override("font_size", 19)
	solo.pressed.connect(_test_solo_selected_weapon)
	detail.add_child(solo)

	var clear := Button.new()
	clear.text = "全武器Lv0"
	clear.custom_minimum_size = Vector2(230, 44)
	clear.add_theme_font_size_override("font_size", 19)
	clear.pressed.connect(_test_clear_all_weapons)
	detail.add_child(clear)

	test_weapon_panel.add_child(box)
	ui.add_child(test_weapon_panel)


func _handle_movement(delta: float, size: Vector2) -> void:
	player_is_moving = false
	var keyboard := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if keyboard.length() > 0.01:
		target_pos = player_pos + keyboard * 120.0

	var to_target := target_pos - player_pos
	if to_target.length() > 4.0:
		var step := to_target.normalized() * float(stats["speed"]) * delta
		if step.length() > to_target.length():
			step = to_target
		if abs(step.x) > 0.4:
			player_facing_right = step.x >= 0.0
		player_pos += step
		player_is_moving = step.length() > 0.5
		if player_is_moving:
			player_move_dir = step.normalized()

	player_pos.x = clamp(player_pos.x, 46.0, WORLD_SIZE.x - 46.0)
	player_pos.y = clamp(player_pos.y, 150.0, WORLD_SIZE.y - 54.0)
	target_pos.x = clamp(target_pos.x, 46.0, WORLD_SIZE.x - 46.0)
	target_pos.y = clamp(target_pos.y, 150.0, WORLD_SIZE.y - 54.0)
	_update_camera(size)


func _handle_dash() -> void:
	if dash_cooldown > 0.0 or not Input.is_action_just_pressed("dash"):
		return
	var direction := (target_pos - player_pos).normalized()
	if direction.length() <= 0.01:
		direction = Vector2.UP
	player_pos += direction * 150.0
	player_pos.x = clamp(player_pos.x, 46.0, WORLD_SIZE.x - 46.0)
	player_pos.y = clamp(player_pos.y, 150.0, WORLD_SIZE.y - 54.0)
	_update_camera(get_viewport_rect().size)
	dash_cooldown = 3.8
	_burst(player_pos, Color(0.7, 0.9, 1.0, 0.55), 16)


func _screen_to_world(screen_pos: Vector2) -> Vector2:
	return screen_pos + camera_pos


func _update_camera(size: Vector2) -> void:
	camera_pos = player_pos - size * 0.5
	camera_pos.x = clamp(camera_pos.x, 0.0, maxf(0.0, WORLD_SIZE.x - size.x))
	camera_pos.y = clamp(camera_pos.y, 0.0, maxf(0.0, WORLD_SIZE.y - size.y))


func _random_world_pos_near_player(min_distance: float, max_distance: float) -> Vector2:
	for i in 12:
		var angle := rng.randf_range(0.0, TAU)
		var distance := rng.randf_range(min_distance, max_distance)
		var pos := player_pos + Vector2(cos(angle), sin(angle)) * distance
		if pos.x > 90.0 and pos.x < WORLD_SIZE.x - 90.0 and pos.y > 180.0 and pos.y < WORLD_SIZE.y - 120.0:
			return pos
	return Vector2(
		clamp(player_pos.x + rng.randf_range(-max_distance, max_distance), 90.0, WORLD_SIZE.x - 90.0),
		clamp(player_pos.y + rng.randf_range(-max_distance, max_distance), 180.0, WORLD_SIZE.y - 120.0)
	)


func _spawn_enemy(size: Vector2, elite: bool) -> void:
	var side := rng.randi_range(0, 3)
	var pos := Vector2.ZERO
	if side == 0:
		pos = camera_pos + Vector2(rng.randf_range(20.0, size.x - 20.0), -40.0)
	elif side == 1:
		pos = camera_pos + Vector2(size.x + 40.0, rng.randf_range(180.0, size.y - 120.0))
	elif side == 2:
		pos = camera_pos + Vector2(rng.randf_range(20.0, size.x - 20.0), size.y + 40.0)
	else:
		pos = camera_pos + Vector2(-40.0, rng.randf_range(180.0, size.y - 120.0))
	pos.x = clamp(pos.x, -80.0, WORLD_SIZE.x + 80.0)
	pos.y = clamp(pos.y, -80.0, WORLD_SIZE.y + 80.0)

	var depth := 1.0 + elapsed / 80.0
	var hp := int((14.0 + depth * 5.0) * (1.0 + float(stats.get("difficulty", 0.0))) * (2.6 if elite else 1.0))
	var enemy_type := "elite" if elite else _choose_basic_enemy_type()
	var enemy_id := next_enemy_id
	next_enemy_id += 1
	enemies.append({
		"id": enemy_id,
		"pos": pos,
		"hp": hp,
		"max_hp": hp,
		"radius": 26.0 if elite else 16.0,
		"speed": rng.randf_range(70.0, 105.0) + depth * 9.0 - (18.0 if elite else 0.0),
		"elite": elite,
		"boss": false,
		"enemy_type": enemy_type,
		"facing_right": pos.x <= player_pos.x,
		"hit_timer": 0.0,
		"drone_cd": 0.0,
		"aura_cd": 0.0,
	})


func _spawn_enemy_at(enemy_type: String, pos: Vector2, elite: bool = false, boss: bool = false) -> void:
	var depth := 1.0 + elapsed / 80.0
	var hp := int((18.0 + depth * 5.0) * (1.0 + float(stats.get("difficulty", 0.0))) * (2.7 if elite else 1.0))
	var radius := 26.0 if elite else 16.0
	var speed := 92.0 + depth * 7.0
	if elite:
		speed = 74.0
	if boss:
		hp = 520
		radius = 48.0
		speed = 54.0
		enemy_type = "dark_knight_boss"
	var enemy_id := next_enemy_id
	next_enemy_id += 1
	enemies.append({
		"id": enemy_id,
		"pos": _clamp_world_pos(pos),
		"hp": hp,
		"max_hp": hp,
		"radius": radius,
		"speed": speed,
		"elite": elite or boss,
		"boss": boss,
		"enemy_type": enemy_type,
		"facing_right": pos.x <= player_pos.x,
		"hit_timer": 0.0,
		"drone_cd": 0.0,
		"aura_cd": 0.0,
		"kb_vel": Vector2.ZERO,
	})


func _choose_basic_enemy_type() -> String:
	if elapsed < 15.0:
		return "ghost"
	return "shadow_cat" if rng.randf() < 0.38 else "ghost"


func _spawn_boss(size: Vector2) -> void:
	var pos := camera_pos + Vector2(size.x * 0.5, -92.0)
	var hp := 420 + int(elapsed * 4.0)
	var enemy_id := next_enemy_id
	next_enemy_id += 1
	enemies.append({
			"id": enemy_id,
			"pos": pos,
			"hp": hp,
			"max_hp": hp,
			"radius": 48.0,
			"speed": 58.0,
			"elite": true,
			"boss": true,
			"enemy_type": "dark_knight_boss",
			"facing_right": pos.x <= player_pos.x,
			"hit_timer": 0.0,
			"drone_cd": 0.0,
			"aura_cd": 0.0,
			"kb_vel": Vector2.ZERO,
	})
	status_label.text = "Dungeon guardian incoming."
	_burst(camera_pos + Vector2(size.x * 0.5, 176.0), Color(1.0, 0.35, 0.22, 0.72), 44)


func _spawn_start_events(size: Vector2) -> void:
	_spawn_interactable("chest", _clamp_world_pos(player_pos + Vector2(-260.0, -360.0)))
	_spawn_interactable("merchant", _clamp_world_pos(player_pos + Vector2(260.0, -360.0)))
	_spawn_interactable("altar", _clamp_world_pos(player_pos + Vector2(280.0, -180.0)))


func _setup_test_stage() -> void:
	_update_test_invincible_button()
	stats["damage"] = 18
	stats["range"] = 430.0
	stats["projectiles"] = 2
	stats["magnet"] = 180.0
	stats["speed"] = BASE_PLAYER_SPEED + 20.0
	stats["shield"] = 40
	player_shield = int(stats["shield"])
	max_hp = 180
	player_hp = max_hp
	player_level = 1
	xp = 0
	xp_next = 10
	displayed_xp_ratio = 0.0
	elapsed = 48.0
	spawn_timer = 999.0
	elite_timer = 999.0
	event_timer = 999.0
	backpack["gold"] = 500

	_spawn_interactable("chest", player_pos + Vector2(-310.0, -260.0))
	_spawn_interactable("pot", player_pos + Vector2(-330.0, 180.0))
	_spawn_interactable("altar", player_pos + Vector2(330.0, 180.0))
	_spawn_interactable("merchant", player_pos + Vector2(0.0, -360.0))
	_test_spawn_pack()
	_test_spawn_boss()
	status_label.text = "Test Stage: 敵/エリート/ボス/宝箱/商人/武器を確認できます。"


func _spawn_map_event(size: Vector2) -> void:
	if interactables.size() >= 5:
		return
	var roll := rng.randf()
	var kind := "chest"
	if roll > 0.86:
		kind = "merchant"
	elif roll > 0.72:
		kind = "altar"
	elif roll > 0.22:
		kind = "pot"
	var pos := _random_world_pos_near_player(360.0, 760.0)
	_spawn_interactable(kind, pos)


func _spawn_interactable(kind: String, pos: Vector2) -> void:
	var interactable := {
		"kind": kind,
		"pos": pos,
		"pulse": rng.randf_range(0.0, TAU),
		"used": false,
	}
	interactables.append(interactable)


func _spawn_reward_chest(pos: Vector2, boss_reward: bool) -> void:
	interactables.append({
		"kind": "reward_chest",
		"pos": _clamp_world_pos(pos),
		"pulse": rng.randf_range(0.0, TAU),
		"used": false,
		"reward_locked": boss_reward,
	})


func _clamp_world_pos(pos: Vector2) -> Vector2:
	return Vector2(
		clamp(pos.x, 90.0, WORLD_SIZE.x - 90.0),
		clamp(pos.y, 180.0, WORLD_SIZE.y - 120.0)
	)


func _fire_at_nearest_enemy() -> void:
	var target := _nearest_enemy(float(stats["range"]))
	if target < 0:
		return

	var origin := player_pos + Vector2(0.0, -22.0)
	var target_pos_local := enemies[target]["pos"] as Vector2
	var base_dir := (target_pos_local - origin).normalized()
	var count := int(stats["projectiles"])
	_muzzle_flash(origin, base_dir)
	for i in count:
		var spread := 0.0
		if count > 1:
			spread = (float(i) - float(count - 1) * 0.5) * 0.13
		var dir := base_dir.rotated(spread)
		var projectile_damage := int(stats["damage"])
		projectiles.append({
			"pos": origin,
			"prev_pos": origin - dir * 18.0,
			"vel": dir * PROJECTILE_SPEED * float(stats.get("projectile_speed", 1.0)),
			"damage": projectile_damage,
			"life": 0.72 * float(stats.get("duration", 1.0)),
			"max_life": 0.72 * float(stats.get("duration", 1.0)),
			"pierce": 0,
			"spin": rng.randf_range(0.0, TAU),
			"source": "base",
		})


func _should_fire_base_attack() -> bool:
	if test_mode:
		return false
	return true


func _has_active_weapon() -> bool:
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		if int(weapon_levels.get(String(def["id"]), 0)) > 0:
			return true
	return false


func _nearest_enemy(max_range: float) -> int:
	var best := -1
	var best_dist := max_range
	for i in range(enemies.size()):
		var dist := player_pos.distance_to(enemies[i]["pos"])
		if dist < best_dist:
				best_dist = dist
				best = i
	return best


func _enemy_index_by_id(enemy_id: int) -> int:
	for i in range(enemies.size()):
		if int(enemies[i].get("id", i)) == enemy_id:
			return i
	return -1


func _update_auto_combat_weapons(delta: float) -> void:
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		var weapon_id := String(def["id"])
		if test_weapon_only_mode and weapon_id != test_weapon_selected_id:
			continue
		if weapon_id == "aura":
			continue
		var level := int(weapon_levels.get(weapon_id, 0))
		if level <= 0:
			continue
		weapon_timers[weapon_id] = maxf(0.0, float(weapon_timers.get(weapon_id, 0.0)) - delta)
		if float(weapon_timers[weapon_id]) > 0.0:
			continue
		_trigger_auto_combat_weapon(weapon_id, level)
		weapon_timers[weapon_id] = _auto_combat_weapon_cooldown(weapon_id, level)


func _update_queued_projectile_shots(delta: float) -> void:
	for i in range(queued_projectile_shots.size() - 1, -1, -1):
		var shot := queued_projectile_shots[i]
		shot["delay"] = float(shot["delay"]) - delta
		if float(shot["delay"]) > 0.0:
			queued_projectile_shots[i] = shot
			continue
		queued_projectile_shots.remove_at(i)
		_fire_queued_projectile_shot(shot)


func _trigger_auto_combat_weapon(weapon_id: String, level: int) -> void:
	var power := int(round(float(stats["damage"]) + level * 5.0))
	match weapon_id:
		"flamewalker":
			if not player_is_moving:
				return
			var flame_radius := (72.0 + level * 6.0) * _weapon_stat_multiplier(weapon_id, "range") * _weapon_stat_multiplier(weapon_id, "size")
			var flame_pos := player_pos - player_move_dir * (PLAYER_RADIUS + flame_radius * 0.42)
			_add_damage_zone(flame_pos, flame_radius, 2.4, maxi(6, int(power * 0.42)), Color(1.0, 0.34, 0.08, 0.22), 0.0, "flame", player_move_dir, weapon_id)
			_spawn_flame_step_fx(flame_pos, player_move_dir, flame_radius)
		"katana":
			_fire_katana_slash(level, power, weapon_id)
		"dexecutioner":
			_fire_dexecutioner_blade(level, power)
		"dice":
			_shoot_weapon_projectiles(1 + int(level / 3), rng.randi_range(maxi(4, int(power * 0.55)), int(power * 2.1)), 620.0, 0.85, 0.16, 0, false, "fortune_rune", weapon_id)
		"aegis":
			var recharge_amount := maxi(2, int(float(stats.get("shield", 40)) * 0.15))
			player_shield = mini(int(stats["shield"]), player_shield + recharge_amount)
		"lightning_staff":
			_fire_lightning_weapon(level, power, weapon_id)
		"axe":
			_fire_crescent_axe(level, power, weapon_id)
		"revolver":
			_queue_revolver_burst(level, power, weapon_id)
		"black_hole":
			_black_hole_weapon(level, power, weapon_id)
		"blood_magic":
			_damage_enemies_in_radius(player_pos, 116.0 + level * 10.0, int(power * 1.18), Color(0.98, 0.04, 0.16, 0.55), 0.0, 0.0, Vector2.ZERO, weapon_id)
			if not invincible_mode:
				player_hp = maxi(1, player_hp - maxi(1, 2 + int(level / 2)))
		"wireless_dagger":
			_shoot_weapon_projectiles(2 + level, int(power * 0.72), 780.0, 0.75, 0.72, 0, false, "homing_dagger", weapon_id)
		"banana":
			_fire_rune_boomerang(level, power, weapon_id)
		"shotgun":
			_shoot_weapon_projectiles(4 + level, int(power * 0.58), 820.0, 0.42, 0.58, 0, false, "", weapon_id)
		"sniper_rifle":
			_shoot_weapon_projectiles(1, int(power * 2.6), 1120.0, 0.98, 0.0, 2 + int(level / 2), false, "", weapon_id)
		"fire_staff":
			_shoot_weapon_projectiles(1 + int(level / 2), int(power * 1.05), 600.0, 0.9, 0.18, 1, false, "flare_rod", weapon_id)
		"bow":
			_shoot_weapon_projectiles(2 + int(level / 2), int(power * 0.72), 900.0, 0.76, 0.13, 0, false, "saint_arrow", weapon_id)
		"bone":
			_shoot_weapon_projectiles(1 + int(level / 2), int(power * 0.92), 680.0, 1.05, 0.22, 3, false, "bound_star", weapon_id)
		"tornado":
			var target := _nearest_enemy(999999.0)
			if target < 0:
				return
			var center := enemies[target]["pos"] as Vector2
			var push_dir := (center - player_pos).normalized()
			if push_dir == Vector2.ZERO:
				push_dir = Vector2.RIGHT if player_facing_right else Vector2.LEFT
			var knockback_force := 260.0 + float(level) * 26.0
			_spawn_storm_tornado(center, push_dir, level, int(power * 0.9), knockback_force, weapon_id)
		"frostwalker":
			if not player_is_moving:
				return
			var frost_radius := (76.0 + level * 6.0) * _weapon_stat_multiplier(weapon_id, "range") * _weapon_stat_multiplier(weapon_id, "size")
			var frost_pos := player_pos - player_move_dir * (PLAYER_RADIUS + frost_radius * 0.42)
			_add_damage_zone(frost_pos, frost_radius, 2.6, maxi(5, int(power * 0.34)), Color(0.54, 0.86, 1.0, 0.24), 1.6, "frost", player_move_dir, weapon_id)
		"chunks":
			_spawn_rune_rocks(level, int(power * 1.02), weapon_id)
		"space_noodle":
			_shoot_weapon_projectiles(3 + level, int(power * 0.58), 640.0, 0.72, TAU, 0, true, "cosmic_ribbon", weapon_id)
		"sword":
			_spawn_attack_image_fx(player_pos, "moon_blade", 104.0 + level * 10.0, elapsed * 2.6, 0.30, 0.82, 0.8)
			_damage_enemies_in_radius(player_pos, 82.0 + level * 7.0, int(power * 1.12), Color(0.9, 0.96, 1.0, 0.62), 0.0, 0.0, Vector2.ZERO, weapon_id)
		"landmine":
			_place_auto_combat_mine(level, power, weapon_id)
		"poison_flask":
			_shoot_weapon_projectiles(1 + int(level / 3), int(power * 0.58), 560.0, 0.86, 0.18, 0, false, "venom_bottle", weapon_id)
		"dragon_breath":
			_dragon_breath_weapon(level, power, weapon_id)
		"corrupted_sword":
			_curse_blade_attack(level, power, weapon_id)
		"hero_sword":
			_slash_nearest_enemy(150.0 + level * 20.0, int(power * 2.0), Color(1.0, 0.88, 0.32, 0.74), weapon_id)
		"loose_rocket":
			_shoot_weapon_projectiles(1 + int(level / 2), int(power * 1.05), 760.0, 0.86, 0.22, 1, false, "magic_missile", weapon_id)
		"blood_scythe":
			_blood_scythe_attack(level, power, weapon_id)
		"gravity_spike":
			_cast_gravity_spike(level, power, weapon_id)


func _auto_combat_weapon_cooldown(weapon_id: String, level: int) -> float:
	var base := 2.2
	match weapon_id:
		"flamewalker":
			base = 0.42
		"frostwalker":
			base = 0.42
		"aura", "aegis", "sword":
			base = 1.25
		"revolver":
			base = 1.75
		"bow":
			base = 0.72
		"shotgun", "katana", "wireless_dagger":
			base = 1.15
		"sniper_rifle", "black_hole", "corrupted_sword", "loose_rocket":
			base = 2.7
		"landmine", "banana", "poison_flask", "tornado":
			base = 2.15
		"blood_magic", "dragon_breath":
			base = 1.55
		"blood_scythe":
			base = 1.85
		"gravity_spike":
			base = 2.45
		"space_noodle", "dice", "chunks", "bone", "fire_staff", "lightning_staff", "axe", "hero_sword", "dexecutioner":
			base = 1.65
	var level_reduction := 0.0 if weapon_id == "flamewalker" else float(level - 1) * 0.07
	return maxf(0.2, (base - level_reduction) * float(stats.get("skill_cooldown", 1.0)) * _weapon_stat_multiplier(weapon_id, "cooldown"))


func _aura_radius(level: int) -> float:
	return (74.0 + float(level) * 10.0) * float(stats.get("area_size", 1.0)) * _weapon_stat_multiplier("aura", "range") * _weapon_stat_multiplier("aura", "size")


func _aura_damage_interval(level: int) -> float:
	return maxf(0.18, (0.78 - float(level - 1) * 0.035) * float(stats.get("skill_cooldown", 1.0)) * _weapon_stat_multiplier("aura", "cooldown"))


func _update_aura_damage(delta: float) -> void:
	var level := int(weapon_levels.get("aura", 0))
	if level <= 0:
		return
	if test_weapon_only_mode and test_weapon_selected_id != "aura":
		return
	var radius := _aura_radius(level)
	var damage := _weapon_scaled_damage("aura", int(stats["damage"]) + level * 5)
	for i in range(enemies.size() - 1, -1, -1):
		var enemy := enemies[i]
		var enemy_pos := enemy["pos"] as Vector2
		var aura_cd := maxf(0.0, float(enemy.get("aura_cd", 0.0)) - delta)
		var in_aura := enemy_pos.distance_to(player_pos) <= radius + float(enemy["radius"])
		if not in_aura:
			enemy["aura_cd"] = 0.0
			enemies[i] = enemy
			continue
		if aura_cd > 0.0:
			enemy["aura_cd"] = aura_cd
			enemies[i] = enemy
			continue
		var hit := _roll_damage_hit(damage, _weapon_stat_bonus("aura", "crit_chance"))
		var final_damage := int(hit["damage"])
		if bool(enemy["boss"]):
			final_damage = int(float(final_damage) * float(stats["boss_damage"]))
		enemy = _apply_enemy_damage(enemy, final_damage)
		enemy["aura_cd"] = _aura_damage_interval(level)
		enemies[i] = enemy
		_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
		_hit_spark(enemy_pos, (enemy_pos - player_pos).normalized(), final_damage)
		_on_enemy_hit(enemy_pos)
		if int(enemy["hp"]) <= 0:
			_kill_enemy(i)


func _damage_enemies_in_radius(center: Vector2, radius: float, damage: int, color: Color, chill: float = 0.0, kb_force: float = 0.0, kb_source_pos: Vector2 = Vector2.ZERO, weapon_id: String = "", kb_dir_override: Vector2 = Vector2.ZERO, show_ring: bool = true, scale_damage: bool = true, show_hit_spark: bool = true) -> void:
	var effective_radius := radius * float(stats.get("area_size", 1.0)) * _weapon_stat_multiplier(weapon_id, "range") * _weapon_stat_multiplier(weapon_id, "size")
	if scale_damage:
		damage = _weapon_scaled_damage(weapon_id, damage)
	kb_force *= _weapon_stat_multiplier(weapon_id, "knockback")
	if show_ring:
		_spawn_ring_fx(center, effective_radius * 0.45, color, effective_radius * 2.4, 0.28, 5.0, "rune")
	for ei in range(enemies.size() - 1, -1, -1):
		var enemy := enemies[ei]
		var enemy_pos := enemy["pos"] as Vector2
		if center.distance_to(enemy_pos) > effective_radius + float(enemy["radius"]):
			continue
		var hit := _roll_damage_hit(damage, _weapon_stat_bonus(weapon_id, "crit_chance"))
		var final_damage := int(hit["damage"])
		if bool(enemy["boss"]):
			final_damage = int(float(final_damage) * float(stats["boss_damage"]))
		enemy = _apply_enemy_damage(enemy, final_damage)
		if chill > 0.0:
			enemy["chill_timer"] = maxf(float(enemy.get("chill_timer", 0.0)), chill)
		if kb_force > 0.0:
			var kb_dir := kb_dir_override.normalized()
			if kb_dir == Vector2.ZERO:
				kb_dir = (enemy_pos - (kb_source_pos if kb_source_pos != Vector2.ZERO else center)).normalized()
			if kb_dir == Vector2.ZERO:
				kb_dir = Vector2.UP
			_apply_knockback(ei, kb_dir, kb_force)
		enemies[ei] = enemy
		_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
		if show_hit_spark:
			_hit_spark(enemy_pos, (enemy_pos - center).normalized(), final_damage)
		_on_enemy_hit(enemy_pos)
		if int(enemy["hp"]) <= 0:
			_kill_enemy(ei)


func _spawn_blood_scythe_fx(origin: Vector2, forward: Vector2, radius: float, start_angle: float, end_angle: float, life: float, damage: int, weapon_id: String) -> void:
	_push_effect({
		"kind": "blood_scythe",
		"texture": "blood_scythe",
		"pos": origin,
		"forward": forward,
		"radius": radius,
		"start_angle": start_angle,
		"end_angle": end_angle,
		"life": life,
		"max_life": life,
		"damage": damage,
		"weapon_id": weapon_id,
		"hit_enemy_ids": {},
		"fade": 0.0,
		"color": Color(1.0, 1.0, 1.0, 0.96),
	})


func _blood_scythe_attack(level: int, power: int, weapon_id: String) -> void:
	var forward := player_move_dir
	if forward == Vector2.ZERO:
		forward = Vector2.RIGHT if player_facing_right else Vector2.LEFT
	forward = forward.normalized()
	var start_angle := forward.angle() + PI * 0.25
	var end_angle := forward.angle() - PI * 0.75
	var size_mult := (1.0 + float(level - 1) * 0.08) * _weapon_stat_multiplier(weapon_id, "size")
	var radius := (112.0 + float(level) * 11.0) * _weapon_stat_multiplier(weapon_id, "range") * size_mult
	var missing_hp_ratio := 1.0 - clampf(float(player_hp) / maxf(1.0, float(max_hp)), 0.0, 1.0)
	var damage := _weapon_scaled_damage(weapon_id, int(float(power) * (1.15 + missing_hp_ratio * 0.9)))
	var effect_life := 0.36
	_spawn_blood_scythe_fx(player_pos, forward, radius, start_angle, end_angle, effect_life, damage, weapon_id)


func _damage_enemies_in_scythe_arc(origin: Vector2, forward: Vector2, radius: float, damage: int, weapon_id: String) -> void:
	var hit_origin := origin + forward.normalized() * (radius * 0.62)
	var hit_radius := radius * 1.08
	for ei in range(enemies.size() - 1, -1, -1):
		var enemy := enemies[ei]
		var enemy_pos := enemy["pos"] as Vector2
		var rel := enemy_pos - hit_origin
		var dist := rel.length()
		if dist > hit_radius + float(enemy["radius"]) or dist <= 0.001:
			continue
		var dir := rel / dist
		var angle_delta := wrapf(dir.angle() - forward.angle(), -PI, PI)
		if angle_delta < -PI * 0.75 or angle_delta > PI * 0.25:
			continue
		var hit := _roll_damage_hit(damage, _weapon_stat_bonus(weapon_id, "crit_chance"))
		var final_damage := int(hit["damage"])
		if bool(enemy["boss"]):
			final_damage = int(float(final_damage) * float(stats["boss_damage"]))
		enemy = _apply_enemy_damage(enemy, final_damage)
		enemies[ei] = enemy
		_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
		_hit_spark(enemy_pos, dir, final_damage)
		_on_enemy_hit(enemy_pos)
		if int(enemy["hp"]) <= 0:
			_kill_enemy(ei)


func _blood_scythe_visual_rect(effect: Dictionary) -> Dictionary:
	var max_life := float(effect.get("max_life", 0.36))
	var effect_age := max_life - float(effect["life"])
	var progress: float = clampf(effect_age / maxf(0.001, max_life), 0.0, 1.0)
	progress = smoothstep(0.0, 1.0, progress)
	var start_angle := float(effect.get("start_angle", 0.0))
	var end_angle := float(effect.get("end_angle", start_angle))
	var angle := start_angle + wrapf(end_angle - start_angle, -PI, PI) * progress
	var radius := float(effect["radius"])
	var forward := (effect.get("forward", Vector2.RIGHT) as Vector2).normalized()
	if forward == Vector2.ZERO:
		forward = Vector2.RIGHT
	var pivot_distance := minf(radius * 0.62, 86.0)
	var pivot := (effect["pos"] as Vector2) + forward * pivot_distance
	var texture_size := Vector2.ONE
	var tex := attack_effect_textures.get("blood_scythe", null) as Texture2D
	if tex != null:
		texture_size = tex.get_size()
	var sprite_size := Vector2(radius * 1.70, radius * 1.70 * texture_size.y / texture_size.x)
	var handle_anchor := Vector2(sprite_size.x * 0.62, sprite_size.y * 0.90)
	var blade_local_angle := -2.42
	return {
		"pivot": pivot,
		"angle": angle - blade_local_angle,
		"size": sprite_size,
		"anchor": handle_anchor,
	}


func _circle_overlaps_blood_scythe_rect(enemy_pos: Vector2, enemy_radius: float, rect_data: Dictionary) -> bool:
	var pivot := rect_data["pivot"] as Vector2
	var angle := float(rect_data["angle"])
	var sprite_size := rect_data["size"] as Vector2
	var handle_anchor := rect_data["anchor"] as Vector2
	for sx in [-1.0, -0.5, 0.0, 0.5, 1.0]:
		for sy in [-1.0, -0.5, 0.0, 0.5, 1.0]:
			var sample_offset := Vector2(float(sx), float(sy))
			if sample_offset.length() > 1.0:
				continue
			var sample_pos := enemy_pos + sample_offset * enemy_radius
			var local := (sample_pos - pivot).rotated(-angle) + handle_anchor
			if local.x < 0.0 or local.y < 0.0 or local.x > sprite_size.x or local.y > sprite_size.y:
				continue
			if _blood_scythe_local_point_is_opaque(local, sprite_size):
				return true
	return false


func _blood_scythe_local_point_is_opaque(local: Vector2, sprite_size: Vector2) -> bool:
	if blood_scythe_hit_image == null:
		return true
	var image_size := blood_scythe_hit_image.get_size()
	if image_size.x <= 0 or image_size.y <= 0:
		return true
	var px := clampi(int(local.x / maxf(1.0, sprite_size.x) * float(image_size.x)), 0, image_size.x - 1)
	var py := clampi(int(local.y / maxf(1.0, sprite_size.y) * float(image_size.y)), 0, image_size.y - 1)
	return blood_scythe_hit_image.get_pixel(px, py).a > 0.18


func _update_blood_scythe_hits(effect: Dictionary) -> Dictionary:
	var hit_enemy_ids := effect.get("hit_enemy_ids", {}) as Dictionary
	var rect_data := _blood_scythe_visual_rect(effect)
	var weapon_id := String(effect.get("weapon_id", "blood_scythe"))
	var damage := int(effect.get("damage", 1))
	for ei in range(enemies.size() - 1, -1, -1):
		var enemy := enemies[ei]
		var enemy_id := int(enemy.get("id", ei))
		if hit_enemy_ids.has(enemy_id):
			continue
		var enemy_pos := enemy["pos"] as Vector2
		if not _circle_overlaps_blood_scythe_rect(enemy_pos, float(enemy["radius"]), rect_data):
			continue
		var hit := _roll_damage_hit(damage, _weapon_stat_bonus(weapon_id, "crit_chance"))
		var final_damage := int(hit["damage"])
		if bool(enemy["boss"]):
			final_damage = int(float(final_damage) * float(stats["boss_damage"]))
		enemy = _apply_enemy_damage(enemy, final_damage)
		enemies[ei] = enemy
		hit_enemy_ids[enemy_id] = true
		_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
		_hit_spark(enemy_pos, (enemy_pos - (rect_data["pivot"] as Vector2)).normalized(), final_damage)
		_on_enemy_hit(enemy_pos)
		if int(enemy["hp"]) <= 0:
			_kill_enemy(ei)
	effect["hit_enemy_ids"] = hit_enemy_ids
	return effect


func _cast_gravity_spike(level: int, power: int, weapon_id: String) -> void:
	var target := _nearest_enemy(999999.0)
	if target < 0:
		return
	var center := enemies[target]["pos"] as Vector2
	var size_mult := _weapon_stat_multiplier(weapon_id, "size")
	var radius := (82.0 + float(level) * 9.0) * float(stats.get("area_size", 1.0)) * _weapon_stat_multiplier(weapon_id, "range") * size_mult
	var visual_radius := (96.0 + float(level) * 10.0) * size_mult
	var life := 0.42 * _weapon_stat_multiplier(weapon_id, "duration")
	var impact_time := minf(0.18, life * 0.44)
	_push_effect({
		"kind": "gravity_spike",
		"pos": center,
		"radius": visual_radius,
		"hit_radius": radius,
		"damage": _weapon_scaled_damage(weapon_id, int(power * 1.8)),
		"knockback": 110.0 * _weapon_stat_multiplier(weapon_id, "knockback"),
		"weapon_id": weapon_id,
		"impact_time": impact_time,
		"hit_done": false,
		"seed": rng.randf_range(0.0, TAU),
		"drop_height": visual_radius * 2.9,
		"spike_frames": 6,
		"spike_start_frame": 3,
		"spike_visible_frames": 1,
		"grow": 0.0,
		"life": life,
		"max_life": life,
		"fade": 0.0,
		"color": Color(0.62, 0.20, 1.0, 1.0),
	})


func _resolve_gravity_spike_effect(effect: Dictionary) -> void:
	var center := effect["pos"] as Vector2
	var radius := float(effect.get("hit_radius", effect.get("radius", 96.0)))
	var damage := int(effect.get("damage", 1))
	var weapon_id := String(effect.get("weapon_id", "gravity_spike"))
	var knockback := float(effect.get("knockback", 0.0))
	for ei in range(enemies.size() - 1, -1, -1):
		var enemy := enemies[ei]
		var enemy_pos := enemy["pos"] as Vector2
		if center.distance_to(enemy_pos) > radius + float(enemy["radius"]):
			continue
		var hit := _roll_damage_hit(damage, _weapon_stat_bonus(weapon_id, "crit_chance"))
		var final_damage := int(hit["damage"])
		if bool(enemy["boss"]):
			final_damage = int(float(final_damage) * float(stats["boss_damage"]))
		enemy = _apply_enemy_damage(enemy, final_damage)
		if knockback > 0.0:
			var pull_dir := (center - enemy_pos).normalized()
			if pull_dir == Vector2.ZERO:
				pull_dir = Vector2.UP
			_apply_knockback(ei, pull_dir, knockback)
		enemies[ei] = enemy
		_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
		_hit_spark(enemy_pos, (enemy_pos - center).normalized(), final_damage)
		_on_enemy_hit(enemy_pos)
		if int(enemy["hp"]) <= 0:
			_kill_enemy(ei)


func _spawn_storm_tornado(center: Vector2, push_dir: Vector2, level: int, damage: int, knockback_force: float, weapon_id: String) -> void:
	var life := 0.85
	var visual_radius := 104.0 + float(level) * 12.0
	var hit_radius := (92.0 + float(level) * 12.0) * float(stats.get("area_size", 1.0)) * _weapon_stat_multiplier(weapon_id, "range") * _weapon_stat_multiplier(weapon_id, "size")
	var velocity := push_dir * knockback_force
	_spawn_storm_tornado_fx(center, visual_radius, push_dir, life, velocity)
	storm_tornadoes.append({
		"pos": center,
		"vel": velocity,
		"dir": push_dir,
		"life": life,
		"radius": hit_radius,
		"damage": _weapon_scaled_damage(weapon_id, damage),
		"knockback": knockback_force * _weapon_stat_multiplier(weapon_id, "knockback"),
		"push_speed": knockback_force * 0.85,
		"weapon_id": weapon_id,
		"hit_enemy_ids": {},
	})


func _update_storm_tornadoes(delta: float) -> void:
	for ti in range(storm_tornadoes.size() - 1, -1, -1):
		var tornado := storm_tornadoes[ti]
		tornado["life"] = float(tornado["life"]) - delta
		tornado["pos"] = (tornado["pos"] as Vector2) + (tornado["vel"] as Vector2) * delta
		var tornado_pos := tornado["pos"] as Vector2
		var push_dir := (tornado["dir"] as Vector2).normalized()
		var hit_enemy_ids := tornado.get("hit_enemy_ids", {}) as Dictionary
		for ei in range(enemies.size() - 1, -1, -1):
			var enemy := enemies[ei]
			var enemy_pos := enemy["pos"] as Vector2
			if tornado_pos.distance_to(enemy_pos) > float(tornado["radius"]) + float(enemy["radius"]):
				continue
			var enemy_id := int(enemy.get("id", ei))
			if not hit_enemy_ids.has(enemy_id):
				var hit := _roll_damage_hit(int(tornado["damage"]), _weapon_stat_bonus(String(tornado.get("weapon_id", "")), "crit_chance"))
				var final_damage := int(hit["damage"])
				if bool(enemy["boss"]):
					final_damage = int(float(final_damage) * float(stats["boss_damage"]))
				enemy = _apply_enemy_damage(enemy, final_damage)
				hit_enemy_ids[enemy_id] = true
				enemies[ei] = enemy
				_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
				_hit_spark(enemy_pos, push_dir, final_damage)
				_on_enemy_hit(enemy_pos)
				if int(enemy["hp"]) <= 0:
					_kill_enemy(ei)
					continue
			enemy = enemies[ei]
			enemy["pos"] = (enemy["pos"] as Vector2).move_toward(tornado_pos, float(tornado["push_speed"]) * delta)
			enemies[ei] = enemy
		tornado["hit_enemy_ids"] = hit_enemy_ids
		storm_tornadoes[ti] = tornado
		if float(tornado["life"]) <= 0.0:
			storm_tornadoes.remove_at(ti)


func _apply_enemy_damage(enemy: Dictionary, damage: int) -> Dictionary:
	if not enemy_invincible_mode:
		enemy["hp"] = int(enemy["hp"]) - damage
	enemy["hit_timer"] = HIT_FLASH_TIME
	return enemy


func _add_damage_zone(pos: Vector2, radius: float, life: float, damage: int, color: Color, chill: float = 0.0, style: String = "zone", direction: Vector2 = Vector2.ZERO, weapon_id: String = "") -> void:
	var effective_life := life * float(stats.get("duration", 1.0)) * _weapon_stat_multiplier(weapon_id, "duration")
	burn_zones.append({
		"pos": pos,
		"life": effective_life,
		"max_life": effective_life,
		"damage_timer": 0.0,
		"radius": radius * float(stats.get("area_size", 1.0)) * _weapon_stat_multiplier(weapon_id, "range") * _weapon_stat_multiplier(weapon_id, "size"),
		"damage": _weapon_scaled_damage(weapon_id, damage),
		"color": color,
		"chill": chill,
		"style": style,
		"direction": direction,
		"seed": rng.randf_range(0.0, TAU),
	})


func _spawn_rune_rocks(level: int, damage: int, weapon_id: String) -> void:
	var count := 2 + int(level / 2) + _weapon_int_bonus(weapon_id, "projectiles")
	var orbit_radius := (72.0 + float(level) * 8.0) * _weapon_stat_multiplier(weapon_id, "range")
	var size_mult := (1.0 + float(level - 1) * 0.04) * _weapon_stat_multiplier(weapon_id, "size")
	var orbit_speed := 1.35 * _weapon_stat_multiplier(weapon_id, "projectile_speed") * float(stats.get("projectile_speed", 1.0))
	var hit_radius := 24.0 * size_mult
	while rune_rocks.size() > count:
		rune_rocks.remove_at(rune_rocks.size() - 1)
	for i in count:
		var rock := rune_rocks[i] if i < rune_rocks.size() else {}
		var shared_angle := float(rune_rocks[0].get("angle", rng.randf_range(0.0, TAU))) if rune_rocks.size() > 0 else rng.randf_range(0.0, TAU)
		rock["angle"] = shared_angle + TAU * float(i) / float(count)
		rock.merge({
			"orbit_radius": orbit_radius,
			"orbit_speed": orbit_speed,
			"damage": _weapon_scaled_damage(weapon_id, damage),
			"hit_radius": hit_radius,
			"size": size_mult,
			"weapon_id": weapon_id,
		}, true)
		if not rock.has("hit_cds"):
			rock["hit_cds"] = {}
		if i < rune_rocks.size():
			rune_rocks[i] = rock
		else:
			rune_rocks.append(rock)


func _update_rune_rocks(delta: float) -> void:
	if int(weapon_levels.get("chunks", 0)) <= 0:
		rune_rocks.clear()
		return
	for ri in range(rune_rocks.size() - 1, -1, -1):
		var rock := rune_rocks[ri]
		rock["angle"] = float(rock["angle"]) + float(rock["orbit_speed"]) * delta
		var hit_cds := rock.get("hit_cds", {}) as Dictionary
		for enemy_id in hit_cds.keys():
			hit_cds[enemy_id] = maxf(0.0, float(hit_cds[enemy_id]) - delta)
		var rock_pos := _rune_rock_pos(rock)
		var weapon_id := String(rock.get("weapon_id", ""))
		for ei in range(enemies.size() - 1, -1, -1):
			var enemy := enemies[ei]
			var enemy_pos := enemy["pos"] as Vector2
			if rock_pos.distance_to(enemy_pos) > float(rock["hit_radius"]) + float(enemy["radius"]):
				continue
			var enemy_id := int(enemy.get("id", ei))
			if float(hit_cds.get(enemy_id, 0.0)) > 0.0:
				continue
			var hit := _roll_damage_hit(int(rock["damage"]), _weapon_stat_bonus(weapon_id, "crit_chance"))
			var final_damage := int(hit["damage"])
			if bool(enemy["boss"]):
				final_damage = int(float(final_damage) * float(stats["boss_damage"]))
			enemy = _apply_enemy_damage(enemy, final_damage)
			enemies[ei] = enemy
			hit_cds[enemy_id] = 0.32
			_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
			_hit_spark(rock_pos, (enemy_pos - player_pos).normalized(), final_damage)
			_on_enemy_hit(enemy_pos)
			if int(enemy["hp"]) <= 0:
				_kill_enemy(ei)
		rock["hit_cds"] = hit_cds
		rune_rocks[ri] = rock


func _rune_rock_pos(rock: Dictionary) -> Vector2:
	var angle := float(rock["angle"])
	return player_pos + Vector2(cos(angle), sin(angle)) * float(rock["orbit_radius"])


func _queue_revolver_burst(level: int, power: int, weapon_id: String = "") -> void:
	var shot_count := 4 + _weapon_int_bonus(weapon_id, "projectiles")
	var base_damage := int(power * 0.82)
	for i in shot_count:
		queued_projectile_shots.append({
			"delay": float(i) * 0.25,
			"weapon_id": weapon_id,
			"damage": base_damage,
			"speed": 920.0,
			"life": 0.65,
			"pierce": 0,
			"sprite": "silver_bullet",
			"spread": 0.035,
		})


func _fire_queued_projectile_shot(shot: Dictionary) -> void:
	var weapon_id := String(shot.get("weapon_id", ""))
	var origin := player_pos + Vector2(0.0, -22.0)
	var target := _nearest_enemy(float(stats["range"]) + 360.0)
	var dir := Vector2.RIGHT if player_facing_right else Vector2.LEFT
	if target >= 0:
		var target_pos_local := enemies[target]["pos"] as Vector2
		dir = (target_pos_local - origin).normalized()
		if dir == Vector2.ZERO:
			dir = Vector2.RIGHT if player_facing_right else Vector2.LEFT
	elif player_move_dir != Vector2.ZERO:
		dir = player_move_dir.normalized()
	dir = dir.rotated(rng.randf_range(-float(shot.get("spread", 0.0)), float(shot.get("spread", 0.0))))
	_weapon_muzzle_flash(origin, dir, String(shot.get("sprite", "")))
	var damage := _weapon_scaled_damage(weapon_id, int(shot.get("damage", 1)))
	var speed := float(shot.get("speed", 760.0)) * _weapon_stat_multiplier(weapon_id, "projectile_speed") * float(stats.get("projectile_speed", 1.0))
	var life := float(shot.get("life", 0.72)) * _weapon_stat_multiplier(weapon_id, "duration") * float(stats.get("duration", 1.0))
	var pierce := int(shot.get("pierce", 0)) + _weapon_int_bonus(weapon_id, "pierce")
	projectiles.append({
		"pos": origin,
		"prev_pos": origin - dir * 18.0,
		"vel": dir * speed,
		"damage": damage,
		"life": life,
		"max_life": life,
		"pierce": pierce,
		"spin": rng.randf_range(0.0, TAU),
		"spin_speed": 12.0,
		"sprite": String(shot.get("sprite", "")),
		"size": _weapon_stat_multiplier(weapon_id, "size"),
		"kb_force": 140.0 * maxf(0.0, _weapon_stat_bonus(weapon_id, "knockback")),
		"status_chance": _weapon_stat_bonus(weapon_id, "status_chance"),
		"weapon_id": weapon_id,
		"source": "weapon",
	})


func _shoot_weapon_projectiles(count: int, damage: int, speed: float, life: float, spread: float, pierce: int, random_dirs: bool = false, sprite: String = "", weapon_id: String = "") -> void:
	var origin := player_pos + Vector2(0.0, -22.0)
	var target := _nearest_enemy(float(stats["range"]) + 360.0)
	var base_dir := Vector2.RIGHT.rotated(rng.randf_range(0.0, TAU))
	if target >= 0 and not random_dirs:
		var target_pos_local := enemies[target]["pos"] as Vector2
		base_dir = (target_pos_local - origin).normalized()
	_weapon_muzzle_flash(origin, base_dir, sprite)
	count += _weapon_int_bonus(weapon_id, "projectiles")
	damage = _weapon_scaled_damage(weapon_id, damage)
	speed *= _weapon_stat_multiplier(weapon_id, "projectile_speed")
	life *= _weapon_stat_multiplier(weapon_id, "duration")
	pierce += _weapon_int_bonus(weapon_id, "pierce")
	var size_mult := _weapon_stat_multiplier(weapon_id, "size")
	var kb_force := 140.0 * maxf(0.0, _weapon_stat_bonus(weapon_id, "knockback"))
	var status_chance := _weapon_stat_bonus(weapon_id, "status_chance")
	var initial_target_ids := {}
	var homing_reserved_damage := {}
	for i in count:
		var offset := 0.0
		if random_dirs:
			offset = rng.randf_range(-PI, PI)
		elif count > 1:
			offset = (float(i) - float(count - 1) * 0.5) * spread
		var dir := base_dir.rotated(offset)
		var homing_target := -1
		if sprite == "bound_star":
			var target_idx := _nearest_projectile_target(origin, float(stats["range"]) + 360.0, initial_target_ids)
			if target_idx >= 0:
				var target_enemy := enemies[target_idx]
				initial_target_ids[int(target_enemy.get("id", target_idx))] = true
				var target_dir := ((target_enemy["pos"] as Vector2) - origin).normalized()
				if target_dir != Vector2.ZERO:
					dir = target_dir
		if _is_homing_projectile_sprite(sprite) and not random_dirs:
			homing_target = _select_homing_projectile_target(origin, float(stats["range"]) + 420.0, homing_reserved_damage, damage)
			if homing_target >= 0:
				var homing_enemy := enemies[homing_target]
				var homing_enemy_id := int(homing_enemy.get("id", homing_target))
				homing_reserved_damage[homing_enemy_id] = int(homing_reserved_damage.get(homing_enemy_id, 0)) + damage
				var homing_dir := ((homing_enemy["pos"] as Vector2) - origin).normalized()
				if homing_dir != Vector2.ZERO:
					dir = homing_dir
		var projectile_life := life * float(stats.get("duration", 1.0))
		var projectile_speed := speed * float(stats.get("projectile_speed", 1.0))
		var projectile_draw_size := size_mult
		if sprite == "magic_missile":
			projectile_draw_size *= 1.18 + float(weapon_levels.get(weapon_id, 1)) * 0.08
		var projectile := {
			"pos": origin,
			"prev_pos": origin - dir * 18.0,
			"vel": dir * projectile_speed,
			"damage": damage,
			"life": projectile_life,
			"max_life": projectile_life,
			"pierce": pierce,
			"spin": rng.randf_range(0.0, TAU),
			"spin_speed": 12.0,
			"sprite": sprite,
			"size": projectile_draw_size,
			"kb_force": kb_force,
			"status_chance": status_chance,
			"weapon_id": weapon_id,
			"source": "weapon",
			"boomerang": sprite == "rune_boomerang",
			"bouncing": sprite == "bound_star",
			"homing": _is_homing_projectile_sprite(sprite),
			"target_enemy_id": -1,
			"hit_enemy_ids": {},
			"origin": origin,
			"returning": false,
			"out_life": projectile_life * 0.34,
			"return_speed": projectile_speed * 1.08,
		}
		if homing_target >= 0:
			projectile["target_enemy_id"] = int(enemies[homing_target].get("id", homing_target))
			projectile["homing_turn_rate"] = 5.2 if sprite == "venom_bottle" else (8.0 if sprite == "magic_missile" else 10.0)
		if sprite == "magic_missile":
			projectile["missile_motion"] = true
			projectile["missile_age"] = 0.0
			projectile["missile_start_speed"] = projectile_speed * 0.48
			projectile["missile_max_speed"] = projectile_speed * 1.12
			projectile["missile_weave_phase"] = rng.randf_range(0.0, TAU)
			projectile["missile_weave_sign"] = -1.0 if rng.randi() % 2 == 0 else 1.0
			projectile["vel"] = dir * float(projectile["missile_start_speed"])
		if sprite == "venom_bottle":
			projectile["impact_radius"] = 118.0 + float(weapon_levels.get(weapon_id, 1)) * 12.0
			projectile["impact_visual_radius"] = (70.0 + float(weapon_levels.get(weapon_id, 1)) * 4.0) * size_mult
			projectile["hit_radius"] = 14.0 * size_mult
			projectile["throw_arc_height"] = 52.0 * size_mult
		elif sprite == "magic_missile":
			projectile["impact_radius"] = 82.0 + float(weapon_levels.get(weapon_id, 1)) * 8.0
			projectile["impact_visual_radius"] = (68.0 + float(weapon_levels.get(weapon_id, 1)) * 5.0) * size_mult
			projectile["hit_radius"] = 12.0 * size_mult
		projectiles.append(projectile)


func _fire_rune_boomerang(level: int, power: int, weapon_id: String = "banana") -> void:
	var origin := player_pos + Vector2(0.0, -22.0)
	var target := _nearest_enemy(310.0 * _weapon_stat_multiplier(weapon_id, "range"))
	var base_dir := Vector2.RIGHT.rotated(rng.randf_range(0.0, TAU))
	if target >= 0:
		base_dir = ((enemies[target]["pos"] as Vector2) - origin).normalized()
	if base_dir == Vector2.ZERO:
		base_dir = Vector2.RIGHT if player_facing_right else Vector2.LEFT

	var count := 1 + int(level / 2) + _weapon_int_bonus(weapon_id, "projectiles")
	var damage := _weapon_scaled_damage(weapon_id, int(power * 0.74))
	var outward_distance := (110.0 + float(level) * 24.0) * _weapon_stat_multiplier(weapon_id, "range")
	var size_mult := (1.0 + float(level - 1) * 0.05) * _weapon_stat_multiplier(weapon_id, "size")
	var hit_radius := 13.0 * size_mult
	var max_life := 3.2 * float(stats.get("duration", 1.0)) * _weapon_stat_multiplier(weapon_id, "duration")
	var return_speed := 420.0 * float(stats.get("projectile_speed", 1.0)) * _weapon_stat_multiplier(weapon_id, "projectile_speed")
	var kb_force := 140.0 * maxf(0.0, _weapon_stat_bonus(weapon_id, "knockback"))

	for i in count:
		var offset := 0.0
		if count > 1:
			offset = (float(i) - float(count - 1) * 0.5) * 0.22
		var dir := base_dir.rotated(offset)
		projectiles.append({
			"pos": origin,
			"prev_pos": origin - dir * 18.0,
			"vel": dir * 520.0 * float(stats.get("projectile_speed", 1.0)) * _weapon_stat_multiplier(weapon_id, "projectile_speed"),
			"damage": damage,
			"life": max_life,
			"max_life": max_life,
			"pierce": 999,
			"spin": rng.randf_range(0.0, TAU),
			"spin_speed": 14.5,
			"sprite": "rune_boomerang",
			"size": size_mult,
			"hit_radius": hit_radius,
			"hit_enemies": [],
			"kb_force": kb_force,
			"status_chance": _weapon_stat_bonus(weapon_id, "status_chance"),
			"weapon_id": weapon_id,
			"source": "weapon",
			"boomerang": true,
			"origin": origin,
				"travelled": 0.0,
				"out_distance": outward_distance,
				"out_dir": dir,
				"returning": false,
				"return_speed": return_speed,
		})


func _fire_crescent_axe(level: int, power: int, weapon_id: String = "") -> void:
	var origin := player_pos
	var base_dir := player_move_dir
	if base_dir == Vector2.ZERO:
		base_dir = Vector2.RIGHT if player_facing_right else Vector2.LEFT
	base_dir = base_dir.normalized()
	_weapon_muzzle_flash(origin, base_dir, "crescent_axe")
	var count := 1 + int(level / 2) + _weapon_int_bonus(weapon_id, "projectiles")
	var damage := _weapon_scaled_damage(weapon_id, int(power * 0.95))
	var speed := 310.0 * _weapon_stat_multiplier(weapon_id, "projectile_speed") * float(stats.get("projectile_speed", 1.0))
	var life := 1.45 * _weapon_stat_multiplier(weapon_id, "duration") * float(stats.get("duration", 1.0))
	var size_mult := (1.0 + level * 0.08) * _weapon_stat_multiplier(weapon_id, "size")
	var hit_radius := 34.0 * size_mult
	var pierce := 999 + _weapon_int_bonus(weapon_id, "pierce")
	var kb_force := (120.0 + level * 16.0) * _weapon_stat_multiplier(weapon_id, "knockback")
	for i in count:
		var offset := 0.0
		if count > 1:
			offset = (float(i) - float(count - 1) * 0.5) * 0.22
		var dir := base_dir.rotated(offset)
		projectiles.append({
			"pos": origin,
			"prev_pos": origin - dir * 18.0,
			"vel": dir * speed,
			"damage": damage,
			"life": life,
			"max_life": life,
			"pierce": pierce,
			"spin": rng.randf_range(0.0, TAU),
			"spin_speed": 10.8,
			"sprite": "crescent_axe",
			"size": size_mult,
			"hit_radius": hit_radius,
			"hit_enemies": [],
			"kb_force": kb_force,
			"status_chance": 0.0,
			"weapon_id": weapon_id,
			"source": "weapon",
		})


func _fire_dexecutioner_blade(level: int, power: int) -> void:
	var weapon_id := "dexecutioner"
	var search_range := (108.0 + level * 16.0) * float(stats.get("range", 1.0)) * _weapon_stat_multiplier(weapon_id, "range")
	var target := _nearest_enemy(search_range)
	
	var origin := player_pos + Vector2(0.0, -22.0)
	var dir := Vector2.RIGHT.rotated(rng.randf_range(0.0, TAU))
	if target >= 0:
		var target_pos := enemies[target]["pos"] as Vector2
		dir = (target_pos - origin).normalized()
	else:
		var p_dir := player_move_dir
		if p_dir == Vector2.ZERO:
			p_dir = Vector2.RIGHT if player_facing_right else Vector2.LEFT
		dir = p_dir
		
	var crit_rate := 0.28 + level * 0.03 + _weapon_stat_bonus(weapon_id, "crit_chance")
	var is_crit := rng.randf() < crit_rate
	var crit_mult := 2.2 if is_crit else 1.0
	var final_damage := int(power * 1.35 * crit_mult)
	final_damage = _weapon_scaled_damage(weapon_id, final_damage)
	
	var speed := 880.0 * _weapon_stat_multiplier(weapon_id, "projectile_speed")
	var life := 0.85 * _weapon_stat_multiplier(weapon_id, "duration")
	var size_mult := (1.0 + level * 0.1) * _weapon_stat_multiplier(weapon_id, "size")
	var kb_force := (160.0 + level * 20.0) * _weapon_stat_multiplier(weapon_id, "knockback")
	var pierce := 1 + int(level / 2) + _weapon_int_bonus(weapon_id, "pierce")
	
	projectiles.append({
		"pos": origin,
		"prev_pos": origin - dir * 18.0,
		"vel": dir * speed * float(stats.get("projectile_speed", 1.0)),
		"damage": final_damage,
		"life": life * float(stats.get("duration", 1.0)),
		"max_life": life * float(stats.get("duration", 1.0)),
		"pierce": pierce,
		"spin": 0.0,
		"spin_speed": 8.0,
		"sprite": "dexecutioner_icon",
		"size": size_mult,
		"hit_radius": 18.0 * size_mult,
		"kb_force": kb_force,
		"status_chance": 0.0,
		"weapon_id": weapon_id,
		"source": "weapon",
		"is_crit": is_crit,
		"persist_on_hit": true,
	})


func _fire_katana_slash(level: int, power: int, weapon_id: String = "") -> void:
	var search_range := (120.0 + level * 20.0) * float(stats.get("range", 1.0)) * _weapon_stat_multiplier(weapon_id, "range")
	var target := _nearest_enemy(search_range)
	
	var enemy_pos := player_pos
	var angle := 0.0
	var has_target := false
	if target >= 0:
		enemy_pos = enemies[target]["pos"] as Vector2
		angle = (enemy_pos - player_pos).angle()
		has_target = true
	else:
		var dir := player_move_dir
		if dir == Vector2.ZERO:
			dir = Vector2.RIGHT if player_facing_right else Vector2.LEFT
		enemy_pos = player_pos + dir * 64.0
		angle = dir.angle()
		
	var crit_rate := 0.12 + level * 0.04 + float(stats.get("crit_chance", 0.0)) + _weapon_stat_bonus(weapon_id, "crit_chance")
	var is_crit := rng.randf() < crit_rate
	var final_damage := int(power * (3.8 if is_crit else 1.6))
	final_damage = _weapon_scaled_damage(weapon_id, final_damage)
	
	var size_mult := (1.0 + level * 0.15) * float(stats.get("area_size", 1.0)) * _weapon_stat_multiplier(weapon_id, "size")
	if is_crit:
		size_mult *= 1.4
		
	var slash_radius := 42.0 * size_mult
	var damage_radius := 54.0 * size_mult
	var slash_width := 7.0 * size_mult
	
	var combo_flip := 1.0 if int(elapsed * 5.0) % 2 == 0 else -1.0
	var final_angle := angle + 0.22 * combo_flip
	
	var wave_color := Color(0.86, 0.92, 1.0, 0.78)
	
	# 敵の位置に直接斬撃エフェクトを発生
	if is_crit:
		# クリティカル時は十文字重ね斬り
		_push_effect({
			"kind": "slash",
			"pos": enemy_pos,
			"radius": slash_radius,
			"angle": final_angle,
			"spin": combo_flip,
			"is_gold": false,
			"color": wave_color,
			"life": 0.25,
			"width": slash_width * 1.3,
		})
		_push_effect({
			"kind": "slash",
			"pos": enemy_pos,
			"radius": slash_radius * 0.85,
			"angle": final_angle + PI * 0.5,
			"spin": -combo_flip,
			"is_gold": false,
			"color": wave_color,
			"life": 0.20,
			"width": slash_width * 0.8,
		})
		
		# ド派手な飛び散る火花
		_burst(enemy_pos, wave_color, 16)
		for i in 12:
			var spark_dir := Vector2.RIGHT.rotated(rng.randf_range(-PI, PI))
			_spawn_streak_fx(enemy_pos, spark_dir, wave_color, rng.randf_range(220.0, 480.0), rng.randf_range(12.0, 32.0), rng.randf_range(2.0, 4.0), rng.randf_range(0.18, 0.32))
	else:
		# 通常の青白い斬撃
		_push_effect({
			"kind": "slash",
			"pos": enemy_pos,
			"radius": slash_radius,
			"angle": final_angle,
			"spin": combo_flip,
			"is_gold": false,
			"color": wave_color,
			"life": 0.22,
			"width": slash_width,
		})
		
		# 軽い火花
		for i in 5:
			var spark_dir := Vector2.RIGHT.rotated(angle + PI * 0.5 + rng.randf_range(-1.2, 1.2))
			_spawn_streak_fx(enemy_pos, spark_dir, wave_color, rng.randf_range(160.0, 320.0), rng.randf_range(8.0, 20.0), rng.randf_range(1.5, 3.0), rng.randf_range(0.14, 0.24))

	# ダメージとノックバックの適用
	var kb_force := (130.0 + level * 35.0) * float(stats.get("knockback", 1.0)) * _weapon_stat_multiplier(weapon_id, "knockback")
	if is_crit:
		kb_force *= 1.6

	if has_target and target < enemies.size():
		var enemy := enemies[target]
		var hit := _roll_damage_hit(final_damage)
		var final_dmg := int(hit["damage"])
		if bool(enemy["boss"]):
			final_dmg = int(float(final_dmg) * float(stats["boss_damage"]))
		enemy = _apply_enemy_damage(enemy, final_dmg)
		if kb_force > 0.0:
			var kb_dir := (enemy_pos - player_pos).normalized()
			if kb_dir == Vector2.ZERO:
				kb_dir = Vector2.UP
			var mass := 3.0 if bool(enemy["boss"]) else (1.6 if bool(enemy["elite"]) else 1.0)
			var final_force := kb_force / mass
			var cur_kb := enemy.get("kb_vel", Vector2.ZERO) as Vector2
			enemy["kb_vel"] = cur_kb + kb_dir.normalized() * final_force
		enemies[target] = enemy
		_spawn_damage_number(enemy_pos, final_dmg, is_crit or bool(hit["crit"]), float(enemy["radius"]))
		_hit_spark(enemy_pos, (enemy_pos - player_pos).normalized(), final_dmg)
		_on_enemy_hit(enemy_pos)
		if int(enemy["hp"]) <= 0:
			_kill_enemy(target)

	# 吹き飛ぶ風圧（白いstreakエフェクト）
	var kb_dir := (enemy_pos - player_pos).normalized()
	for i in 3:
		var stream_dir := kb_dir.rotated(rng.randf_range(-0.35, 0.35))
		_spawn_streak_fx(enemy_pos, stream_dir, Color(1.0, 1.0, 1.0, 0.44), rng.randf_range(380.0, 680.0), rng.randf_range(16.0, 38.0), rng.randf_range(2.0, 4.2), rng.randf_range(0.16, 0.28))


func _slash_nearest_enemy(range: float, damage: int, color: Color, weapon_id: String = "") -> void:
	range *= _weapon_stat_multiplier(weapon_id, "range")
	var target := _nearest_enemy(range)
	if target < 0:
		_damage_enemies_in_radius(player_pos, 72.0, int(damage * 0.5), color, 0.0, 0.0, Vector2.ZERO, weapon_id)
		return
	var enemy_pos := enemies[target]["pos"] as Vector2
	var angle := (enemy_pos - player_pos).angle()
	_spawn_slash_fx(enemy_pos, 42.0 * _weapon_stat_multiplier(weapon_id, "size"), angle, color, 0.22, 7.0)
	_damage_enemies_in_radius(enemy_pos, 54.0, damage, color, 0.0, 0.0, Vector2.ZERO, weapon_id)


func _curse_blade_attack(level: int, power: int, weapon_id: String) -> void:
	var attack_range := (150.0 + float(level) * 18.0) * _weapon_stat_multiplier(weapon_id, "range")
	var target := _nearest_enemy(attack_range)
	if target < 0:
		return
	var enemy := enemies[target]
	var enemy_pos := enemy["pos"] as Vector2
	var visual_radius := (104.0 + float(level) * 10.0) * _weapon_stat_multiplier(weapon_id, "size")
	var damage := _weapon_scaled_damage(weapon_id, int(power * 1.08))
	_spawn_curse_blade_slash(enemy_pos, visual_radius, false, 0.0)
	_apply_curse_blade_hit(target, damage, weapon_id)
	_spawn_curse_blade_slash(enemy_pos, visual_radius, true, 0.15, int(enemy.get("id", target)), damage, weapon_id)


func _apply_curse_blade_hit(target_index: int, damage: int, weapon_id: String) -> void:
	if target_index < 0 or target_index >= enemies.size():
		return
	var enemy := enemies[target_index]
	var enemy_pos := enemy["pos"] as Vector2
	var hit := _roll_damage_hit(damage, _weapon_stat_bonus(weapon_id, "crit_chance"))
	var final_damage := int(hit["damage"])
	if bool(enemy["boss"]):
		final_damage = int(float(final_damage) * float(stats["boss_damage"]))
	enemy = _apply_enemy_damage(enemy, final_damage)
	enemies[target_index] = enemy
	_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
	_hit_spark(enemy_pos, (enemy_pos - player_pos).normalized(), final_damage)
	_on_enemy_hit(enemy_pos)
	if int(enemy["hp"]) <= 0:
		_kill_enemy(target_index)


func _spawn_lightning_fx(impact_pos: Vector2, height: float = 480.0) -> void:
	var life := 0.30
	_push_effect({
		"kind": "lightning",
		"pos": impact_pos,
		"height": height,
		"seed": rng.randf_range(0.0, TAU),
		"life": life,
		"max_life": life,
		"color": Color.WHITE
	})


func _fire_lightning_weapon(level: int, damage: int, weapon_id: String = "") -> void:
	var target := _nearest_enemy((float(stats["range"]) + 260.0) * _weapon_stat_multiplier(weapon_id, "range"))
	if target < 0 or target >= enemies.size():
		return
	var enemy_pos := enemies[target]["pos"] as Vector2
	var enemy := enemies[target]
	var enemy_radius := float(enemy["radius"])
	var lightning_impact_pos := enemy_pos + Vector2(0.0, -enemy_radius - 8.0)
	var lightning_height := (260.0 + level * 18.0) * _weapon_stat_multiplier(weapon_id, "size")
	_spawn_lightning_fx(lightning_impact_pos, lightning_height)
	var hit := _roll_damage_hit(_weapon_scaled_damage(weapon_id, damage), _weapon_stat_bonus(weapon_id, "crit_chance"))
	var final_dmg := int(hit["damage"])
	if bool(enemy["boss"]):
		final_dmg = int(float(final_dmg) * float(stats["boss_damage"]))
	enemy = _apply_enemy_damage(enemy, final_dmg)
	if _weapon_stat_bonus(weapon_id, "status_chance") > 0.0 and rng.randf() < _weapon_stat_bonus(weapon_id, "status_chance"):
		enemy["chill_timer"] = maxf(float(enemy.get("chill_timer", 0.0)), 0.75)
	enemies[target] = enemy
	_spawn_damage_number(enemy_pos, final_dmg, bool(hit["crit"]), enemy_radius)
	_hit_spark(lightning_impact_pos, Vector2.DOWN, final_dmg)
	if int(enemy["hp"]) <= 0:
		_kill_enemy(target)


func _black_hole_weapon(level: int, damage: int, weapon_id: String = "") -> void:
	var center := player_pos
	var target := _nearest_enemy(float(stats["range"]) + 320.0)
	if target >= 0:
		center = enemies[target]["pos"] as Vector2
	var gate_life := NIGHTMARE_GATE_LIFE * float(stats.get("duration", 1.0)) * _weapon_stat_multiplier(weapon_id, "duration")
	var pull_radius := (150.0 + level * 18.0) * _weapon_stat_multiplier(weapon_id, "range") * _weapon_stat_multiplier(weapon_id, "size")
	var visual_radius := pull_radius * NIGHTMARE_GATE_VISUAL_SCALE
	_spawn_ring_fx(center, visual_radius, Color(0.38, 0.06, 0.74, 0.78), 0.0, gate_life, 8.0, "nightmare_gate")
	nightmare_gates.append({
		"pos": center,
		"radius": pull_radius,
		"hit_radius": visual_radius * NIGHTMARE_GATE_HIT_SCALE,
		"damage": int(damage * 0.82),
		"hit_enemy_ids": {},
		"weapon_id": weapon_id,
		"life": gate_life,
		"max_life": gate_life,
		"pull_start": NIGHTMARE_GATE_PULL_START * _weapon_stat_multiplier(weapon_id, "knockback"),
		"pull_end": (NIGHTMARE_GATE_PULL_END + level * 34.0) * _weapon_stat_multiplier(weapon_id, "knockback"),
	})
	while nightmare_gates.size() > 8:
		nightmare_gates.remove_at(0)


func _update_nightmare_gates(delta: float) -> void:
	for gi in range(nightmare_gates.size() - 1, -1, -1):
		var gate := nightmare_gates[gi]
		var center := gate["pos"] as Vector2
		var radius := float(gate["radius"])
		var max_life := maxf(0.01, float(gate["max_life"]))
		gate["life"] = float(gate["life"]) - delta
		var progress := clampf(1.0 - float(gate["life"]) / max_life, 0.0, 1.0)
		var accel := progress * progress
		var pull_speed := lerpf(float(gate["pull_start"]), float(gate["pull_end"]), accel)
		for ei in range(enemies.size() - 1, -1, -1):
			var enemy := enemies[ei]
			var enemy_pos := enemy["pos"] as Vector2
			var dist := center.distance_to(enemy_pos)
			if dist > radius or dist <= 1.0:
				continue
			var center_bias := 0.72 + (1.0 - clampf(dist / radius, 0.0, 1.0)) * 0.46
			enemy["pos"] = enemy_pos.move_toward(center, pull_speed * center_bias * delta)
			enemies[ei] = enemy
		gate = _damage_enemies_at_nightmare_gate_center(gate)
		if float(gate["life"]) <= 0.0:
			nightmare_gates.remove_at(gi)
		else:
			nightmare_gates[gi] = gate


func _damage_enemies_at_nightmare_gate_center(gate: Dictionary) -> Dictionary:
	var center := gate["pos"] as Vector2
	var hit_radius := float(gate["hit_radius"])
	var weapon_id := String(gate.get("weapon_id", ""))
	var damage := _weapon_scaled_damage(weapon_id, int(gate.get("damage", 1)))
	var hit_enemy_ids := gate.get("hit_enemy_ids", {}) as Dictionary
	for ei in range(enemies.size() - 1, -1, -1):
		var enemy := enemies[ei]
		var enemy_id := int(enemy.get("id", ei))
		if hit_enemy_ids.has(enemy_id):
			continue
		var enemy_pos := enemy["pos"] as Vector2
		if center.distance_to(enemy_pos) > hit_radius + float(enemy["radius"]):
			continue
		hit_enemy_ids[enemy_id] = true
		var hit := _roll_damage_hit(damage, _weapon_stat_bonus(weapon_id, "crit_chance"))
		var final_damage := int(hit["damage"])
		if bool(enemy["boss"]):
			final_damage = int(float(final_damage) * float(stats["boss_damage"]))
		enemy = _apply_enemy_damage(enemy, final_damage)
		enemies[ei] = enemy
		_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
		_hit_spark(enemy_pos, (enemy_pos - center).normalized(), final_damage)
		_on_enemy_hit(enemy_pos)
		if int(enemy["hp"]) <= 0:
			_kill_enemy(ei)
	gate["hit_enemy_ids"] = hit_enemy_ids
	return gate


func _explode_near_enemy(radius: float, damage: int, color: Color, zone_life: float = 0.0, weapon_id: String = "") -> void:
	var center := player_pos + Vector2(rng.randf_range(-110.0, 110.0), rng.randf_range(-110.0, 110.0))
	var target := _nearest_enemy(float(stats["range"]) + 260.0)
	if target >= 0:
		center = enemies[target]["pos"] as Vector2
	var is_venom := weapon_id == "poison_flask"
	if is_venom:
		var splash_radius := radius * float(stats.get("area_size", 1.0)) * _weapon_stat_multiplier(weapon_id, "range") * _weapon_stat_multiplier(weapon_id, "size")
		_spawn_venom_splash_fx(center, splash_radius)
	_damage_enemies_in_radius(center, radius, damage, color, 0.0, 0.0, Vector2.ZERO, weapon_id, Vector2.ZERO, not is_venom)
	if zone_life > 0.0:
		_add_damage_zone(center, radius * 0.72, zone_life, maxi(5, int(damage * 0.22)), color, 0.0, "zone", Vector2.ZERO, weapon_id)


func _place_auto_combat_mine(level: int, damage: int, weapon_id: String = "") -> void:
	mines.append({
		"pos": player_pos,
		"life": (6.0 + level * 0.35) * _weapon_stat_multiplier(weapon_id, "duration"),
		"armed": 0.35,
		"radius": 24.0 * _weapon_stat_multiplier(weapon_id, "size"),
		"damage": _weapon_scaled_damage(weapon_id, int(damage * 1.45)),
		"explode_radius": (104.0 + level * 10.0) * _weapon_stat_multiplier(weapon_id, "range") * _weapon_stat_multiplier(weapon_id, "size"),
		"knockback": 180.0 * _weapon_stat_multiplier(weapon_id, "knockback"),
		"burn": level >= 3,
		"sprite": "trap_rune",
	})


func _dragon_breath_weapon(level: int, damage: int, weapon_id: String = "") -> void:
	var dir := Vector2.RIGHT if player_facing_right else Vector2.LEFT
	var range_mult := _weapon_stat_multiplier(weapon_id, "range")
	var size_mult := _weapon_stat_multiplier(weapon_id, "size")
	var center := player_pos + dir * ((72.0 + level * 5.0) * range_mult)
	var breath_origin := player_pos + dir * (PLAYER_RADIUS * 0.65)
	_spawn_flare_breath_fx(
		breath_origin,
		(150.0 + level * 14.0) * size_mult * maxf(0.85, range_mult),
		dir.angle(),
		0.38 * _weapon_stat_multiplier(weapon_id, "duration")
	)
	for ei in range(enemies.size() - 1, -1, -1):
		var enemy := enemies[ei]
		var enemy_pos := enemy["pos"] as Vector2
		var rel := enemy_pos - player_pos
		if rel.length() > (150.0 + level * 16.0) * range_mult:
			continue
		if rel.normalized().dot(dir) < 0.2:
			continue
		var hit := _roll_damage_hit(_weapon_scaled_damage(weapon_id, damage), _weapon_stat_bonus(weapon_id, "crit_chance"))
		var final_damage := int(hit["damage"])
		enemy = _apply_enemy_damage(enemy, final_damage)
		enemies[ei] = enemy
		_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
		_hit_spark(enemy_pos, dir, final_damage)
		_on_enemy_hit(enemy_pos)
		if int(enemy["hp"]) <= 0:
			_kill_enemy(ei)


func _update_projectiles(delta: float) -> void:
	for pi in range(projectiles.size() - 1, -1, -1):
		var projectile := projectiles[pi]
		if test_mode and String(projectile.get("source", "")) != "weapon":
			projectiles.remove_at(pi)
			continue
		var previous_pos := projectile["pos"] as Vector2
		projectile["prev_pos"] = previous_pos
		if bool(projectile.get("boomerang", false)):
			var out_dir := projectile.get("out_dir", Vector2.RIGHT) as Vector2
			if bool(projectile.get("returning", false)):
				var return_dir := (player_pos - previous_pos).normalized()
				if return_dir != Vector2.ZERO:
					var current_speed := (projectile["vel"] as Vector2).length()
					var target_speed := float(projectile.get("return_speed", current_speed))
					var return_speed := move_toward(current_speed, target_speed, target_speed * 1.9 * delta)
					projectile["vel"] = (projectile["vel"] as Vector2).move_toward(return_dir * return_speed, return_speed * 3.8 * delta)
			else:
				var travelled := float(projectile.get("travelled", 0.0))
				var out_distance := maxf(1.0, float(projectile.get("out_distance", 150.0)))
				var progress := clampf(travelled / out_distance, 0.0, 1.0)
				var speed_mult := lerpf(1.0, 0.76, progress * progress)
				var curve_dir := out_dir.rotated(sin(progress * PI) * 0.42)
				var base_speed := float(projectile.get("return_speed", 420.0)) * 1.18
				projectile["vel"] = curve_dir.normalized() * base_speed * speed_mult
				projectile["travelled"] = travelled + ((projectile["vel"] as Vector2).length() * delta)
				if float(projectile["travelled"]) >= out_distance:
					projectile["returning"] = true
					projectile["hit_enemies"] = []
					projectile["life"] = maxf(float(projectile["life"]), 1.2)
		elif bool(projectile.get("homing", false)):
			var target_id := int(projectile.get("target_enemy_id", -1))
			var target_index := _enemy_index_by_id(target_id)
			if target_index < 0:
				target_index = _nearest_projectile_target(previous_pos, float(stats["range"]) + 420.0, {})
				if target_index >= 0:
					projectile["target_enemy_id"] = int(enemies[target_index].get("id", target_index))
			if target_index >= 0:
				var target_pos := enemies[target_index]["pos"] as Vector2
				var homing_dir := (target_pos - previous_pos).normalized()
				if homing_dir != Vector2.ZERO:
					if bool(projectile.get("missile_motion", false)):
						var missile_age := float(projectile.get("missile_age", 0.0)) + delta
						projectile["missile_age"] = missile_age
						var accel_t := clampf(missile_age / 0.38, 0.0, 1.0)
						var ease_t := 1.0 - pow(1.0 - accel_t, 2.0)
						var start_speed := float(projectile.get("missile_start_speed", (projectile["vel"] as Vector2).length()))
						var max_speed := float(projectile.get("missile_max_speed", start_speed))
						var desired_speed := lerpf(start_speed, max_speed, ease_t)
						var weave_phase := float(projectile.get("missile_weave_phase", 0.0))
						var weave_sign := float(projectile.get("missile_weave_sign", 1.0))
						var weave := sin(missile_age * 10.5 + weave_phase) * weave_sign * lerpf(0.42, 0.10, accel_t)
						var side := Vector2(-homing_dir.y, homing_dir.x)
						var missile_dir := (homing_dir + side * weave).normalized()
						var turn_rate := lerpf(3.2, float(projectile.get("homing_turn_rate", 8.0)), ease_t)
						projectile["vel"] = (projectile["vel"] as Vector2).move_toward(missile_dir * desired_speed, desired_speed * turn_rate * delta)
					else:
						var current_speed := (projectile["vel"] as Vector2).length()
						var desired_vel := homing_dir * current_speed
						var turn_rate := float(projectile.get("homing_turn_rate", 8.0))
						projectile["vel"] = (projectile["vel"] as Vector2).move_toward(desired_vel, current_speed * turn_rate * delta)
		projectile["pos"] += projectile["vel"] * delta
		projectile["life"] -= delta
		projectile["spin"] = float(projectile["spin"]) + delta * float(projectile.get("spin_speed", 12.0))
		projectiles[pi] = projectile
		if bool(projectile.get("boomerang", false)) and bool(projectile.get("returning", false)) and (projectile["pos"] as Vector2).distance_to(player_pos) <= 22.0:
			projectiles.remove_at(pi)
			continue
		if not bool(projectile.get("boomerang", false)) and projectile["life"] <= 0.0:
			projectiles.remove_at(pi)
			continue

		var projectile_removed := false
		for ei in range(enemies.size() - 1, -1, -1):
			var enemy := enemies[ei]
			var enemy_pos := enemy["pos"] as Vector2
			var bouncing_projectile := bool(projectile.get("bouncing", false))
			var hit_enemies := projectile.get("hit_enemies", []) as Array
			var hit_enemy_ids := projectile.get("hit_enemy_ids", {}) as Dictionary
			var enemy_id := int(enemy.get("id", ei))
			if bouncing_projectile:
				if hit_enemy_ids.has(enemy_id):
					continue
			elif hit_enemies.has(ei):
				continue
			if projectile["pos"].distance_to(enemy_pos) <= float(enemy["radius"]) + float(projectile.get("hit_radius", 8.0)):
				var projectile_weapon := String(projectile.get("weapon_id", ""))
				var projectile_sprite := String(projectile.get("sprite", ""))
				if projectile_weapon == "poison_flask" and String(projectile.get("sprite", "")) == "venom_bottle":
					_trigger_venom_bottle_impact(projectile, enemy_pos)
					projectiles.remove_at(pi)
					projectile_removed = true
					break
				if projectile_sprite == "magic_missile":
					_trigger_magic_missile_impact(projectile, enemy_pos)
					projectiles.remove_at(pi)
					projectile_removed = true
					break
				var projectile_crit := bool(projectile.get("is_crit", false))
				var extra_crit_chance := 0.0 if projectile_crit else _weapon_stat_bonus(projectile_weapon, "crit_chance")
				var hit := _roll_damage_hit(int(projectile["damage"]), extra_crit_chance)
				var damage := int(hit["damage"])
				if bool(enemy["boss"]):
					damage = int(float(damage) * float(stats["boss_damage"]))
				enemy = _apply_enemy_damage(enemy, damage)
				if float(stats["frost_chance"]) > 0.0 and rng.randf() < float(stats["frost_chance"]):
					enemy["chill_timer"] = max(float(enemy.get("chill_timer", 0.0)), 1.4)
				if float(projectile.get("status_chance", 0.0)) > 0.0 and rng.randf() < float(projectile["status_chance"]):
					enemy["chill_timer"] = max(float(enemy.get("chill_timer", 0.0)), 1.2)
				var kb_force := float(projectile.get("kb_force", 0.0))
				if kb_force > 0.0:
					var kb_dir := (projectile["vel"] as Vector2).normalized()
					_apply_knockback(ei, kb_dir, kb_force)
				enemies[ei] = enemy
				if bouncing_projectile:
					hit_enemy_ids[enemy_id] = true
					projectile["hit_enemy_ids"] = hit_enemy_ids
				else:
					hit_enemies.append(ei)
					projectile["hit_enemies"] = hit_enemies
				_spawn_damage_number(enemy_pos, damage, projectile_crit or bool(hit["crit"]), float(enemy["radius"]))
				_hit_spark(projectile["pos"], (projectile["vel"] as Vector2).normalized(), damage)
				_on_enemy_hit(enemy_pos)
				if int(enemy["hp"]) <= 0:
					_kill_enemy(ei)
				if bool(projectile.get("persist_on_hit", false)):
					projectiles[pi] = projectile
				elif bool(projectile.get("boomerang", false)):
					projectiles[pi] = projectile
				elif bouncing_projectile:
					if int(projectile["pierce"]) > 0:
						projectile["pierce"] = int(projectile["pierce"]) - 1
						var bounce_target := _nearest_bounce_target(enemy_pos, hit_enemy_ids)
						if bounce_target >= 0:
							var target_pos := enemies[bounce_target]["pos"] as Vector2
							var bounce_dir := (target_pos - (projectile["pos"] as Vector2)).normalized()
							if bounce_dir != Vector2.ZERO:
								projectile["vel"] = bounce_dir * (projectile["vel"] as Vector2).length()
							projectiles[pi] = projectile
						else:
							projectiles.remove_at(pi)
							projectile_removed = true
						break
					else:
						projectiles.remove_at(pi)
						projectile_removed = true
						break
				elif int(projectile["pierce"]) > 0:
					projectile["pierce"] = int(projectile["pierce"]) - 1
					projectiles[pi] = projectile
				else:
					projectiles.remove_at(pi)
					projectile_removed = true
					break
		if projectile_removed:
			continue


func _nearest_bounce_target(from_pos: Vector2, hit_enemy_ids: Dictionary) -> int:
	var best := -1
	var best_dist := INF
	for ei in range(enemies.size()):
		var enemy := enemies[ei]
		if hit_enemy_ids.has(int(enemy.get("id", ei))):
			continue
		var dist := from_pos.distance_squared_to(enemy["pos"] as Vector2)
		if dist < best_dist:
			best_dist = dist
			best = ei
	return best


func _nearest_projectile_target(from_pos: Vector2, max_range: float, claimed_enemy_ids: Dictionary) -> int:
	var best := -1
	var best_dist := max_range * max_range
	for ei in range(enemies.size()):
		var enemy := enemies[ei]
		if claimed_enemy_ids.has(int(enemy.get("id", ei))):
			continue
		var dist := from_pos.distance_squared_to(enemy["pos"] as Vector2)
		if dist < best_dist:
			best_dist = dist
			best = ei
	return best


func _is_homing_projectile_sprite(sprite: String) -> bool:
	return sprite == "homing_dagger" or sprite == "magic_missile" or sprite == "venom_bottle"


func _select_homing_projectile_target(from_pos: Vector2, max_range: float, reserved_damage: Dictionary, shot_damage: int) -> int:
	var best := -1
	var best_dist := max_range * max_range
	var fallback := -1
	var fallback_dist := max_range * max_range
	for ei in range(enemies.size()):
		var enemy := enemies[ei]
		var enemy_pos := enemy["pos"] as Vector2
		var dist := from_pos.distance_squared_to(enemy_pos)
		if dist > max_range * max_range:
			continue
		var enemy_id := int(enemy.get("id", ei))
		var remaining_hp := int(enemy["hp"]) - int(reserved_damage.get(enemy_id, 0))
		if dist < fallback_dist:
			fallback_dist = dist
			fallback = ei
		if remaining_hp <= 0:
			continue
		if dist < best_dist:
			best_dist = dist
			best = ei
	if best >= 0:
		return best
	return fallback


func _update_drones(delta: float) -> void:
	var drone_count := int(stats["drone_count"])
	if drone_count <= 0:
		return
	var drone_positions := _drone_positions()
	for ei in range(enemies.size() - 1, -1, -1):
		var enemy := enemies[ei]
		enemy["drone_cd"] = max(0.0, float(enemy["drone_cd"]) - delta)
		var enemy_pos := enemy["pos"] as Vector2
		if float(enemy["drone_cd"]) <= 0.0:
			for drone_pos in drone_positions:
				if enemy_pos.distance_to(drone_pos) <= float(enemy["radius"]) + 18.0:
					var hit := _roll_damage_hit(int(stats["drone_damage"]) + (5 if bool(evolved_weapons["drone"]) else 0))
					var damage := int(hit["damage"])
					enemy = _apply_enemy_damage(enemy, damage)
					enemy["drone_cd"] = 0.14 if bool(evolved_weapons["drone"]) else 0.22
					_spawn_damage_number(enemy_pos, damage, bool(hit["crit"]), float(enemy["radius"]))
					_burst(enemy_pos, Color(0.52, 0.9, 1.0, 0.55), 4)
					_on_enemy_hit(enemy_pos)
					break
		enemies[ei] = enemy
		if int(enemy["hp"]) <= 0:
			_kill_enemy(ei)


func _drone_positions() -> Array[Vector2]:
	var positions: Array[Vector2] = []
	if not stats.has("drone_count"):
		return positions
	var drone_count := int(stats["drone_count"])
	if drone_count <= 0:
		return positions
	var radius := float(stats["drone_radius"]) + (28.0 if bool(evolved_weapons["drone"]) else 0.0)
	for i in drone_count:
		var angle := drone_angle + TAU * float(i) / float(drone_count)
		positions.append(player_pos + Vector2(cos(angle), sin(angle)) * radius)
	return positions


func _cast_lightning() -> void:
	var extra_targets := 2 if bool(evolved_weapons["lightning"]) else 0
	var targets := _nearest_enemies(float(stats["range"]) + 130.0, int(stats["lightning_targets"]) + extra_targets)
	targets.sort()
	targets.reverse()
	for index in targets:
		if index < 0 or index >= enemies.size():
			continue
		var enemy := enemies[index]
		var enemy_pos := enemy["pos"] as Vector2
		var hit := _roll_damage_hit(int(stats["lightning_damage"]) + (12 if bool(evolved_weapons["lightning"]) else 0))
		var damage := int(hit["damage"])
		enemy = _apply_enemy_damage(enemy, damage)
		enemies[index] = enemy
		_spawn_damage_number(enemy_pos, damage, bool(hit["crit"]), float(enemy["radius"]))
		_spawn_beam_fx(player_pos + Vector2(0.0, -24.0), enemy_pos, Color(0.78, 0.92, 1.0, 1.0), 0.18, 7.0)
		_burst(enemy_pos, Color(0.8, 0.92, 1.0, 0.7), 9)
		_on_enemy_hit(enemy_pos)
		if bool(evolved_weapons["lightning"]):
			_chain_shock(enemy_pos, int(damage * 0.5), index)
		if int(enemy["hp"]) <= 0:
			_kill_enemy(index)


func _chain_shock(pos: Vector2, damage: int, source_index: int) -> void:
	for ei in range(enemies.size() - 1, -1, -1):
		if ei == source_index:
			continue
		var enemy := enemies[ei]
		var enemy_pos := enemy["pos"] as Vector2
		if pos.distance_to(enemy_pos) <= 120.0:
			var hit := _roll_damage_hit(damage)
			var final_damage := int(hit["damage"])
			enemy = _apply_enemy_damage(enemy, final_damage)
			enemies[ei] = enemy
			_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
			_spawn_beam_fx(pos, enemy_pos, Color(0.78, 0.92, 1.0, 1.0), 0.12, 5.0)
			_on_enemy_hit(enemy_pos)


func _nearest_enemies(max_range: float, count: int) -> Array[int]:
	var ranked: Array[Dictionary] = []
	for i in range(enemies.size()):
		var dist := player_pos.distance_to(enemies[i]["pos"])
		if dist <= max_range:
			ranked.append({"index": i, "dist": dist})
	ranked.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		return float(a["dist"]) < float(b["dist"])
	)
	var result: Array[int] = []
	for i in range(min(count, ranked.size())):
		result.append(int(ranked[i]["index"]))
	return result


func _drop_mine() -> void:
	mines.append({
		"pos": player_pos,
		"life": 5.0,
		"armed": 0.45,
		"radius": 24.0,
	})


func _update_mines(delta: float) -> void:
	for mi in range(mines.size() - 1, -1, -1):
		var mine := mines[mi]
		mine["life"] = float(mine["life"]) - delta
		mine["armed"] = max(0.0, float(mine["armed"]) - delta)
		mines[mi] = mine
		if float(mine["life"]) <= 0.0:
			mines.remove_at(mi)
			continue
		if float(mine["armed"]) > 0.0:
			continue
		var mine_pos := mine["pos"] as Vector2
		for ei in range(enemies.size() - 1, -1, -1):
			var enemy := enemies[ei]
			var enemy_pos := enemy["pos"] as Vector2
			if mine_pos.distance_to(enemy_pos) <= float(enemy["radius"]) + 30.0:
				_explode_mine(mi, mine_pos)
				break


func _explode_mine(index: int, pos: Vector2) -> void:
	if index < 0 or index >= mines.size():
		return
	var mine := mines[index]
	mines.remove_at(index)
	var damage := int(mine.get("damage", stats.get("mine_damage", 0)))
	var explode_radius := float(mine.get("explode_radius", 118.0)) * float(stats.get("area_size", 1.0))
	_spawn_trap_explosion_fx(pos, explode_radius)
	if bool(mine.get("burn", false)):
		burn_zones.append({
			"pos": pos,
			"life": 3.5 * float(stats.get("duration", 1.0)),
			"max_life": 3.5 * float(stats.get("duration", 1.0)),
			"damage_timer": 0.0,
			"radius": 116.0 * float(stats.get("area_size", 1.0)),
			"damage": maxi(5, int(float(damage) * 0.22)),
			"color": Color(1.0, 0.42, 0.12, 0.2),
			"chill": 0.0,
			"style": "hidden",
		})
	for ei in range(enemies.size() - 1, -1, -1):
		var enemy := enemies[ei]
		var enemy_pos := enemy["pos"] as Vector2
		if pos.distance_to(enemy_pos) <= explode_radius + float(enemy["radius"]):
			var hit := _roll_damage_hit(damage)
			var final_damage := int(hit["damage"])
			enemy = _apply_enemy_damage(enemy, final_damage)
			var kb_force := float(mine.get("knockback", 0.0))
			if kb_force > 0.0:
				var kb_dir := (enemy_pos - pos).normalized()
				if kb_dir == Vector2.ZERO:
					kb_dir = Vector2.UP
				_apply_knockback(ei, kb_dir, kb_force)
			enemies[ei] = enemy
			_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
			_hit_spark(enemy_pos, (enemy_pos - pos).normalized(), final_damage)
			_on_enemy_hit(enemy_pos)
			if int(enemy["hp"]) <= 0:
				_kill_enemy(ei)


func _trigger_venom_bottle_impact(projectile: Dictionary, enemy_pos: Vector2) -> void:
	var weapon_id := String(projectile.get("weapon_id", "poison_flask"))
	var impact_pos := enemy_pos
	var radius := float(projectile.get("impact_radius", 118.0))
	var visual_radius := float(projectile.get("impact_visual_radius", 74.0))
	var damage := int(projectile.get("damage", 0))
	var color := Color(0.48, 1.0, 0.24, 0.5)
	_spawn_venom_splash_fx(impact_pos, visual_radius, damage, radius, color, 3.6, weapon_id)


func _trigger_magic_missile_impact(projectile: Dictionary, enemy_pos: Vector2) -> void:
	var weapon_id := String(projectile.get("weapon_id", "loose_rocket"))
	if weapon_id == "":
		weapon_id = "loose_rocket"
	var impact_pos := enemy_pos
	var radius := float(projectile.get("impact_radius", 90.0))
	var visual_radius := float(projectile.get("impact_visual_radius", 72.0))
	var damage := int(projectile.get("damage", 0))
	var color := Color(0.48, 0.42, 1.0, 0.55)
	_spawn_magic_missile_explosion_fx(impact_pos, visual_radius)
	_damage_enemies_in_radius(impact_pos, radius, damage, color, 0.0, 0.0, Vector2.ZERO, weapon_id, Vector2.ZERO, false, false, false)


func _resolve_venom_splash_effect(effect: Dictionary) -> void:
	var pos := effect["pos"] as Vector2
	var radius := float(effect.get("damage_radius", effect.get("radius", 118.0)))
	var damage := int(effect.get("damage", 0))
	var color := effect.get("damage_color", Color(0.48, 1.0, 0.24, 0.5)) as Color
	var weapon_id := String(effect.get("weapon_id", "poison_flask"))
	_damage_enemies_in_radius(pos, radius, damage, color, 0.0, 0.0, Vector2.ZERO, weapon_id, Vector2.ZERO, false, false)
	var zone_life := float(effect.get("zone_life", 0.0))
	if zone_life > 0.0:
		_add_damage_zone(pos, radius * 0.72, zone_life, maxi(5, int(damage * 0.22)), color, 0.0, "hidden", Vector2.ZERO, weapon_id)


func _update_burn_zones(delta: float) -> void:
	for zi in range(burn_zones.size() - 1, -1, -1):
		var zone := burn_zones[zi]
		zone["life"] = float(zone["life"]) - delta
		zone["damage_timer"] = float(zone["damage_timer"]) - delta
		var zone_pos := zone["pos"] as Vector2
		if float(zone["damage_timer"]) <= 0.0:
			zone["damage_timer"] = 0.35
			for ei in range(enemies.size() - 1, -1, -1):
				var enemy := enemies[ei]
				var enemy_pos := enemy["pos"] as Vector2
				if zone_pos.distance_to(enemy_pos) <= float(zone["radius"]) + float(enemy["radius"]):
					var hit := _roll_damage_hit(int(zone.get("damage", maxi(4, int(float(stats.get("mine_damage", 16)) / 4.0)))))
					var final_damage := int(hit["damage"])
					enemy = _apply_enemy_damage(enemy, final_damage)
					if float(zone.get("chill", 0.0)) > 0.0:
						enemy["chill_timer"] = maxf(float(enemy.get("chill_timer", 0.0)), float(zone["chill"]))
					enemies[ei] = enemy
					_spawn_damage_number(enemy_pos, final_damage, bool(hit["crit"]), float(enemy["radius"]))
					_on_enemy_hit(enemy_pos)
					if int(enemy["hp"]) <= 0:
						_kill_enemy(ei)
		burn_zones[zi] = zone
		if float(zone["life"]) <= 0.0:
			burn_zones.remove_at(zi)


func _apply_knockback(enemy_idx: int, dir: Vector2, force: float) -> void:
	if enemy_idx < 0 or enemy_idx >= enemies.size():
		return
	var enemy := enemies[enemy_idx]
	var mass := 3.0 if bool(enemy["boss"]) else (1.6 if bool(enemy["elite"]) else 1.0)
	var final_force := force / mass
	var cur_kb := enemy.get("kb_vel", Vector2.ZERO) as Vector2
	enemy["kb_vel"] = cur_kb + dir.normalized() * final_force
	enemies[enemy_idx] = enemy


func _update_enemies(delta: float, size: Vector2) -> void:
	for i in range(enemies.size() - 1, -1, -1):
		var enemy := enemies[i]
		var enemy_pos := enemy["pos"] as Vector2
		
		# Apply knockback velocity
		var kb_vel := enemy.get("kb_vel", Vector2.ZERO) as Vector2
		if kb_vel.length_squared() > 0.01:
			enemy_pos += kb_vel * delta
			kb_vel = kb_vel.move_toward(Vector2.ZERO, 620.0 * delta)
			enemy["kb_vel"] = kb_vel
			
		var dir := (player_pos - enemy_pos).normalized()
		var chill_timer: float = max(0.0, float(enemy.get("chill_timer", 0.0)) - delta)
		enemy["chill_timer"] = chill_timer
		var speed_multiplier: float = 0.62 if chill_timer > 0.0 else 1.0
		enemy_pos += dir * float(enemy["speed"]) * speed_multiplier * delta
		var contact_distance := float(enemy["radius"]) + PLAYER_RADIUS
		var player_delta := player_pos - enemy_pos
		var player_distance := player_delta.length()
		if player_distance < contact_distance and player_distance > 0.001:
			enemy_pos = player_pos - player_delta.normalized() * contact_distance
		enemy["pos"] = enemy_pos
		if absf(dir.x) > 0.04:
			enemy["facing_right"] = dir.x > 0.0
		enemy["hit_timer"] = max(0.0, float(enemy["hit_timer"]) - delta)
		enemies[i] = enemy

	_separate_enemies()

	for i in range(enemies.size() - 1, -1, -1):
		var enemy := enemies[i]
		var enemy_pos := enemy["pos"] as Vector2
		var contact_distance := float(enemy["radius"]) + PLAYER_RADIUS
		if enemy_pos.distance_to(player_pos) <= contact_distance + 0.5:
			var base_damage := 24 if bool(enemy["boss"]) else (16 if bool(enemy["elite"]) else 9)
			var damage: int = maxi(2, base_damage - int(stats["armor"]))
			_damage_player(damage)
			if int(stats.get("thorns", 0)) > 0:
				enemy = _apply_enemy_damage(enemy, int(stats["thorns"]))
			_burst(player_pos, Color(1.0, 0.22, 0.22, 0.5), 18)
			if int(enemy["hp"]) <= 0:
				_kill_enemy(i)
			else:
				enemies[i] = enemy
			if player_hp <= 0:
				_fail_run()
				return

	if EXTRACTION_ENABLED and extract_open and player_pos.distance_to(extract_pos) < 78.0 and Input.is_action_just_pressed("extract"):
		_try_extract()

	if enemies.size() < 8 and elapsed > 18.0:
		_spawn_enemy(size, false)


func _separate_enemies() -> void:
	for i in range(enemies.size()):
		for j in range(i + 1, enemies.size()):
			var a := enemies[i]
			var b := enemies[j]
			var a_pos := a["pos"] as Vector2
			var b_pos := b["pos"] as Vector2
			var delta := b_pos - a_pos
			var distance := delta.length()
			var min_distance := float(a["radius"]) + float(b["radius"]) + 2.0
			if distance >= min_distance:
				continue
			var direction := Vector2.RIGHT.rotated(rng.randf_range(0.0, TAU)) if distance <= 0.001 else delta / distance
			var push := (min_distance - distance) * 0.5
			var a_weight := 0.35 if bool(a.get("boss", false)) else 1.0
			var b_weight := 0.35 if bool(b.get("boss", false)) else 1.0
			var total_weight := a_weight + b_weight
			a_pos -= direction * push * (b_weight / total_weight) * 2.0
			b_pos += direction * push * (a_weight / total_weight) * 2.0
			a["pos"] = _enemy_pos_outside_player(a_pos, float(a["radius"]))
			b["pos"] = _enemy_pos_outside_player(b_pos, float(b["radius"]))
			enemies[i] = a
			enemies[j] = b


func _enemy_pos_outside_player(pos: Vector2, enemy_radius: float) -> Vector2:
	var contact_distance := enemy_radius + PLAYER_RADIUS
	var player_delta := player_pos - pos
	var player_distance := player_delta.length()
	if player_distance < contact_distance and player_distance > 0.001:
		return player_pos - player_delta.normalized() * contact_distance
	return pos


func _damage_player(amount: int) -> void:
	if invincible_mode:
		return
	if float(stats.get("evasion", 0.0)) > 0.0 and rng.randf() < float(stats["evasion"]):
		_burst(player_pos, Color(0.74, 0.9, 1.0, 0.48), 10)
		return
	var remaining := amount
	if player_shield > 0:
		var blocked := mini(player_shield, remaining)
		player_shield -= blocked
		remaining -= blocked
	if remaining > 0:
		player_hp -= remaining
		if treasure_counts.has("golden_shield"):
			_spawn_loot_item(player_pos, "gold", maxi(1, int(remaining * 0.4)), 20.0)
		if treasure_counts.has("electric_plug"):
			_damage_enemies_in_radius(player_pos, 108.0, maxi(5, int(float(stats["damage"]) * 0.8)), Color(0.72, 0.94, 1.0, 0.54), 0.6)
		if treasure_counts.has("poison_barrel"):
			_add_damage_zone(player_pos, 104.0, 3.0, maxi(4, int(float(stats["damage"]) * 0.25)), Color(0.46, 1.0, 0.18, 0.16))
	shield_recharge_timer = 4.0


func _update_passive_recovery(delta: float) -> void:
	if treasure_counts.has("suction_magnet"):
		_collect_all_pickups()
	if float(stats.get("regen", 0.0)) > 0.0:
		regen_timer += delta
		if regen_timer >= 1.0:
			regen_timer -= 1.0
			player_hp = mini(max_hp, player_hp + int(stats["regen"]))
	if int(stats.get("shield", 0)) > 0 and shield_recharge_timer <= 0.0 and player_shield < int(stats["shield"]):
		player_shield = mini(int(stats["shield"]), player_shield + maxi(1, int(float(stats["shield"]) * delta * 0.55)))


func _roll_damage_hit(damage: int, extra_crit_chance: float = 0.0, extra_crit_damage: float = 0.0) -> Dictionary:
	if float(stats.get("low_hp_damage", 0.0)) > 0.0:
		var missing_ratio := 1.0 - clampf(float(player_hp) / float(max_hp), 0.0, 1.0)
		damage = int(float(damage) * (1.0 + missing_ratio * float(stats["low_hp_damage"])))
	if float(stats.get("bonk_chance", 0.0)) > 0.0 and rng.randf() < float(stats["bonk_chance"]):
		return {"damage": damage * 20, "crit": true}
	if float(stats.get("execute_chance", 0.0)) > 0.0 and rng.randf() < float(stats["execute_chance"]):
		stats["damage"] += 1
		return {"damage": damage * 24, "crit": true}
	var crit_chance := clampf(float(stats.get("crit_chance", 0.0)) + extra_crit_chance, 0.0, 0.95)
	if crit_chance > 0.0 and rng.randf() < crit_chance:
		var multiplier := float(stats.get("crit_damage", 1.75)) + extra_crit_damage
		if treasure_counts.has("giant_fork") and rng.randf() < 0.28:
			multiplier = maxf(multiplier, 2.5)
		var crit_damage := int(float(damage) * multiplier)
		if treasure_counts.has("demon_blade") and rng.randf() < 0.25:
			player_hp = mini(max_hp, player_hp + 2)
		return {"damage": maxi(1, crit_damage), "crit": true}
	return {"damage": maxi(1, damage), "crit": false}


func _roll_outgoing_damage(damage: int) -> int:
	return int(_roll_damage_hit(damage)["damage"])


func _on_enemy_hit(pos: Vector2) -> void:
	if resolving_hit_effects:
		return
	resolving_hit_effects = true
	if float(stats.get("lifesteal_chance", 0.0)) > 0.0 and rng.randf() < float(stats["lifesteal_chance"]):
		player_hp = mini(max_hp, player_hp + 1)
		_burst(pos, Color(0.92, 0.05, 0.18, 0.42), 4)
	if float(stats.get("poison_chance", 0.0)) > 0.0 and rng.randf() < float(stats["poison_chance"]):
		_add_damage_zone(pos, 54.0, 2.2, maxi(2, int(float(stats["damage"]) * 0.18)), Color(0.46, 1.0, 0.18, 0.16))
	if float(stats.get("explode_chance", 0.0)) > 0.0 and rng.randf() < float(stats["explode_chance"]):
		_spawn_ring_fx(pos, 12.0, Color(1.0, 0.42, 0.12, 0.62), 118.0, 0.28, 5.0, "rune")
		_damage_enemies_in_radius(pos, 96.0, maxi(5, int(float(stats["damage"]) * 0.65)), Color(1.0, 0.38, 0.12, 0.48))
	if float(stats.get("lightning_chance", 0.0)) > 0.0 and rng.randf() < float(stats["lightning_chance"]):
		_spawn_beam_fx(player_pos + Vector2(0.0, -24.0), pos, Color(0.78, 0.92, 1.0, 1.0), 0.16, 6.0)
		_damage_enemies_in_radius(pos, 48.0, maxi(5, int(float(stats["damage"]) * 0.72)), Color(0.76, 0.94, 1.0, 0.55), 1.0)
	resolving_hit_effects = false


func _update_loot(delta: float) -> void:
	for i in range(loot.size() - 1, -1, -1):
		var item := loot[i]
		var pos := item["pos"] as Vector2
		var dist := pos.distance_to(player_pos)
		if dist < float(stats["magnet"]):
			pos = pos.move_toward(player_pos, 520.0 * delta)
			item["pos"] = pos
			loot[i] = item
		if dist < PLAYER_RADIUS + 18.0:
			_collect_loot(item)
			loot.remove_at(i)


func _update_xp_bar_display(delta: float) -> void:
	if not started:
		displayed_xp_ratio = 0.0
		return
	var target_ratio: float = 1.0 if choice_open else clampf(float(xp) / maxf(1.0, float(xp_next)), 0.0, 1.0)
	if target_ratio < displayed_xp_ratio - 0.45:
		displayed_xp_ratio = target_ratio
		return
	var speed := 5.6 if target_ratio > displayed_xp_ratio else 9.0
	displayed_xp_ratio = lerpf(displayed_xp_ratio, target_ratio, 1.0 - exp(-speed * delta))


func _update_effects(delta: float) -> void:
	for i in range(effects.size() - 1, -1, -1):
		var effect := effects[i]
		if effect.has("vel"):
			effect["pos"] = (effect["pos"] as Vector2) + (effect["vel"] as Vector2) * delta
		effect["life"] -= delta
		if effect.has("radius"):
			effect["radius"] = float(effect["radius"]) + float(effect.get("grow", 0.0)) * delta
		if effect.has("angle"):
			var spin_duration := float(effect.get("spin_duration", -1.0))
			var spin_elapsed := float(effect.get("max_life", effect["life"])) - float(effect["life"])
			if spin_duration < 0.0 or spin_elapsed <= spin_duration:
				effect["angle"] = float(effect["angle"]) + float(effect.get("spin", 0.0)) * delta
		var effect_kind := String(effect.get("kind", ""))
		if effect_kind == "gravity_spike":
			var effect_age := float(effect.get("max_life", effect["life"])) - float(effect["life"])
			if not bool(effect.get("hit_done", false)) and effect_age >= float(effect.get("impact_time", 0.36)):
				_resolve_gravity_spike_effect(effect)
				effect["hit_done"] = true
		if effect_kind == "venom_splash":
			var venom_effect_age := float(effect.get("max_life", effect["life"])) - float(effect["life"])
			if effect.has("damage") and not bool(effect.get("hit_done", false)) and venom_effect_age >= float(effect.get("damage_delay", 0.16)):
				_resolve_venom_splash_effect(effect)
				effect["hit_done"] = true
		if effect_kind == "attack_image" and effect.has("hit_enemy_id"):
			var attack_effect_age := float(effect.get("max_life", effect["life"])) - float(effect["life"])
			if not bool(effect.get("hit_done", false)) and attack_effect_age >= float(effect.get("hit_delay", 0.0)):
				var hit_target := _enemy_index_by_id(int(effect["hit_enemy_id"]))
				if hit_target >= 0:
					_apply_curse_blade_hit(hit_target, int(effect.get("damage", 0)), String(effect.get("weapon_id", "")))
				effect["hit_done"] = true
		if effect_kind == "blood_scythe":
			effect = _update_blood_scythe_hits(effect)
		var color := effect["color"] as Color
		if String(effect.get("style", "")) != "nightmare_gate":
			color.a = max(0.0, color.a - delta * float(effect.get("fade", 1.9)))
		effect["color"] = color
		effects[i] = effect
		if float(effect["life"]) <= 0.0:
			effects.remove_at(i)


func _update_beams(delta: float) -> void:
	for i in range(beams.size() - 1, -1, -1):
		var beam := beams[i]
		beam["life"] = float(beam["life"]) - delta
		beams[i] = beam
		if float(beam["life"]) <= 0.0:
			beams.remove_at(i)


func _kill_enemy(index: int) -> void:
	var enemy := enemies[index]
	var pos := enemy["pos"] as Vector2
	var elite := bool(enemy["elite"])
	enemies.remove_at(index)
	kills += 1
	if float(stats.get("kill_damage_gain", 0.0)) > 0.0:
		stats["damage"] += maxf(0.05, float(stats["kill_damage_gain"]))
	_drop_xp(pos, 7 if bool(enemy["boss"]) else (3 if elite else 1))
	if float(stats.get("bonus_xp_chance", 0.0)) > 0.0 and rng.randf() < float(stats["bonus_xp_chance"]):
		_drop_xp(pos, 2)
	_drop_loot(pos, elite)
	if elite:
		_spawn_reward_chest(pos, bool(enemy["boss"]))
	if float(stats.get("burger_chance", 0.0)) > 0.0 and rng.randf() < float(stats["burger_chance"]):
		_spawn_loot_item(pos, "meat", 20, 20.0)
	if treasure_counts.has("soul_harvester"):
		_shoot_weapon_projectiles(2, maxi(4, int(float(stats["damage"]) * 0.8)), 740.0, 0.75, TAU, 0, true)
	if treasure_counts.has("loose_cannon"):
		if rng.randf() < 0.20:
			_shoot_weapon_projectiles(1, maxi(8, int(float(stats["damage"]) * 1.5)), 760.0, 0.86, 0.22, 1, false, "magic_missile")
	_death_burst(pos, elite, bool(enemy["boss"]))


func _drop_loot(pos: Vector2, elite: bool) -> void:
	var rolls := 4 if elite and rng.randf() > 0.55 else (2 if elite else 1)
	for i in rolls:
		var kind := "gold"
		var value := rng.randi_range(2, 5)
		var roll := rng.randf()
		if roll > 0.96:
			kind = "magnet"
			value = 1
		elif roll > 0.91:
			kind = "meat"
			value = 18
		elif elite and roll > 0.72:
			kind = "relics"
			value = 1
		elif roll > 0.86:
			kind = "keys"
			value = 1
		elif roll > 0.66:
			kind = "ore"
			value = rng.randi_range(1, 2)
		_add_loot_item(pos, kind, value, 20.0)


func _drop_xp(pos: Vector2, value: int) -> void:
	_add_loot_item(pos, "xp", value, 18.0)


func _add_loot_item(pos: Vector2, kind: String, value: int, spread: float) -> void:
	var drop_pos := pos + Vector2(rng.randf_range(-spread, spread), rng.randf_range(-spread, spread))
	loot.append({
		"pos": drop_pos,
		"kind": kind,
		"value": value,
		"bob": rng.randf_range(0.0, TAU),
	})
	_compact_loot_if_needed()


func _compact_loot_if_needed() -> void:
	while loot.size() > MAX_LOOT_ITEMS:
		var remove_index := -1
		var farthest_dist := -1.0
		for i in range(loot.size() - 1, -1, -1):
			var item := loot[i]
			var kind := String(item["kind"])
			if kind != "xp" and kind != "gold":
				continue
			var pos := item["pos"] as Vector2
			var dist := pos.distance_to(player_pos)
			if dist > farthest_dist:
				farthest_dist = dist
				remove_index = i
		if remove_index < 0:
			remove_index = 0
		loot.remove_at(remove_index)


func _collect_loot(item: Dictionary) -> void:
	var kind := String(item["kind"])
	if kind == "xp":
		var amount := maxi(1, int(round(float(item["value"]) * float(stats["xp_gain"]))))
		_gain_xp(amount)
		_spawn_pickup_feedback(kind, amount)
		_burst(player_pos, _loot_color(kind), 4)
		return
	if kind == "meat":
		player_hp = mini(max_hp, player_hp + int(item["value"]))
		_spawn_pickup_feedback(kind, int(item["value"]))
		_burst(player_pos, _loot_color(kind), 8)
		return
	if kind == "magnet":
		_collect_all_pickups()
		_spawn_pickup_feedback(kind, 0)
		_burst(player_pos, _loot_color(kind), 18)
		return
	var value := int(item["value"])
	if kind == "gold":
		value = maxi(1, int(round(float(value) * float(stats["gold_gain"]))))
	backpack[kind] += value
	_spawn_pickup_feedback(kind, value)
	_burst(player_pos, _loot_color(kind), 5)


func _spawn_pickup_feedback(kind: String, value: int) -> void:
	var color := _loot_color(kind)
	var label := "+%d" % value
	if kind == "xp":
		label = "+%d XP" % value
	elif kind == "gold":
		label = "+%d G" % value
	elif kind == "meat":
		label = "+%d HP" % value
	elif kind == "magnet":
		label = "PULL"
	elif kind == "keys":
		label = "+%d KEY" % value
	elif kind == "ore":
		label = "+%d ORE" % value
	elif kind == "relics":
		label = "+%d RELIC" % value
	_push_effect({
		"kind": "float_text",
		"pos": player_pos + Vector2(rng.randf_range(-18.0, 18.0), -24.0 + rng.randf_range(-8.0, 8.0)),
		"vel": Vector2(rng.randf_range(-8.0, 8.0), -54.0),
		"life": 0.62,
		"color": Color(color.r, color.g, color.b, 0.96),
		"fade": 1.35,
		"text": label,
		"size": 16 if kind == "xp" or kind == "gold" else 15,
	})
	_spawn_ring_fx(player_pos, 10.0, Color(color.r, color.g, color.b, 0.36), 24.0, 0.18, 2.4)


func _gain_xp(amount: int) -> void:
	xp += amount
	while xp >= xp_next and not choice_open:
		xp -= xp_next
		player_level += 1
		xp_next += 6
		_open_upgrade_choices()


func _collect_all_pickups() -> void:
	for i in range(loot.size()):
		var item := loot[i]
		var kind := String(item["kind"])
		if kind == "magnet":
			continue
		item["pos"] = player_pos
		loot[i] = item


func _nearest_interactable() -> int:
	var best := -1
	var best_dist := INTERACT_RANGE
	for i in range(interactables.size()):
		if String(interactables[i].get("kind", "")) == "reward_chest":
			continue
		var pos := interactables[i]["pos"] as Vector2
		var dist := player_pos.distance_to(pos)
		if dist < best_dist:
			best_dist = dist
			best = i
	return best


func _update_reward_chests() -> void:
	for i in range(interactables.size() - 1, -1, -1):
		var interactable := interactables[i]
		if String(interactable.get("kind", "")) != "reward_chest":
			continue
		var pos := interactable["pos"] as Vector2
		if player_pos.distance_to(pos) > INTERACT_RANGE:
			interactable["auto_touching"] = false
			interactables[i] = interactable
			continue
		if _open_chest(pos, bool(interactable.get("reward_locked", false)), true, false):
			interactables.remove_at(i)
			return
		if i < interactables.size():
			interactable["auto_touching"] = true
			interactables[i] = interactable


func _update_touch_interactables() -> void:
	for i in range(interactables.size() - 1, -1, -1):
		var interactable := interactables[i]
		var kind := String(interactable.get("kind", ""))
		if kind != "chest" and kind != "locked_chest" and kind != "merchant" and kind != "altar" and kind != "pot":
			continue
		if bool(interactable.get("used", false)):
			continue
		var pos := interactable["pos"] as Vector2
		if player_pos.distance_to(pos) > INTERACT_RANGE:
			interactable["auto_touching"] = false
			interactables[i] = interactable
			continue
		if bool(interactable.get("auto_touching", false)):
			if kind == "chest" and int(backpack["gold"]) < _chest_open_cost():
				continue
			if kind == "locked_chest" and (int(backpack["keys"]) <= 0 or int(backpack["gold"]) < _chest_open_cost()):
				continue
			if kind != "merchant" and kind != "locked_chest" and kind != "chest":
				continue
		_interact_index(i)
		if choice_open:
			return
		if i < interactables.size():
			var current := interactables[i]
			if String(current.get("kind", "")) == kind and (current["pos"] as Vector2).distance_to(pos) < 1.0:
				current["auto_touching"] = true
				interactables[i] = current


func _update_interaction_ui() -> void:
	if run_over or choice_open:
		interact_button.visible = false
		return
	var index := _nearest_interactable()
	if index < 0:
		interact_button.visible = false
		return
	if bool(interactables[index].get("used", false)):
		interact_button.visible = false
		return
	var kind := String(interactables[index]["kind"])
	interact_button.visible = true
	if kind == "altar":
		interact_button.text = "祭壇を使う"
	elif kind == "pot":
		interact_button.text = "壺を壊す"
	elif kind == "merchant":
		interact_button.text = "商人を見る"
	elif kind == "locked_chest":
		interact_button.text = "鍵 + %dG" % _chest_open_cost()
	else:
		interact_button.text = "宝箱を開ける %dG" % _chest_open_cost()


func _interact_nearby() -> void:
	var index := _nearest_interactable()
	if index < 0:
		return
	_interact_index(index)


func _interact_index(index: int) -> void:
	if index < 0 or index >= interactables.size():
		return
	var interactable := interactables[index]
	var kind := String(interactable["kind"])
	var pos := interactable["pos"] as Vector2
	if bool(interactable.get("used", false)):
		return
	if kind == "altar":
		_use_curse_altar(pos)
		interactable["used"] = true
		interactables[index] = interactable
	elif kind == "pot":
		_break_pot(pos)
		interactables.remove_at(index)
	elif kind == "merchant":
		_open_merchant_choices(pos, index)
	elif kind == "locked_chest":
		var free_open := float(stats.get("key_open_chance", 0.0)) > 0.0 and rng.randf() < float(stats["key_open_chance"])
		if int(backpack["keys"]) <= 0 and not free_open:
			status_label.text = "鍵付き宝箱には鍵が必要。"
			return
		if _open_chest(pos, true, free_open):
			if not free_open:
				backpack["keys"] -= 1
			interactables.remove_at(index)
	elif kind == "chest":
		if _open_chest(pos, false):
			interactables.remove_at(index)
	else:
		_open_chest(pos, false)
		interactables.remove_at(index)
	_update_interaction_ui()


func _chest_open_cost() -> int:
	return CHEST_OPEN_BASE_COST + chest_open_count * CHEST_OPEN_COST_STEP


func _open_chest(pos: Vector2, locked: bool, free_open: bool = false, count_open: bool = true) -> bool:
	var cost := _chest_open_cost()
	if not free_open and int(backpack["gold"]) < cost:
		status_label.text = "宝箱を開けるには %dG 必要。" % cost
		_burst(pos, Color(0.95, 0.18, 0.18, 0.42), 8)
		return false
	if not free_open:
		backpack["gold"] -= cost
	if count_open:
		chest_open_count += 1
	_drop_chest_items(pos, locked)
	_spawn_opened_chest_fx(pos)
	_open_chest_reward(_roll_treasure(locked), pos, locked)
	if locked:
		_drop_xp(pos, 8)
	else:
		_drop_xp(pos, 3)
	if free_open and count_open:
		status_label.text = "宝箱を無料で開けた。次回 %dG" % _chest_open_cost()
	elif free_open:
		status_label.text = "報酬宝箱を開けた。"
	else:
		status_label.text = "宝箱を開けた: -%dG  次回 %dG" % [cost, _chest_open_cost()]
	_burst(pos, Color(1.0, 0.78, 0.25, 0.72), 24 if locked else 14)
	return true


func _spawn_opened_chest_fx(pos: Vector2) -> void:
	opened_chests.append({
		"pos": pos,
		"time": 0.0,
	})


func _update_opened_chests(delta: float) -> void:
	for i in range(opened_chests.size()):
		var chest := opened_chests[i]
		chest["time"] = float(chest.get("time", 0.0)) + delta
		opened_chests[i] = chest


func _open_chest_reward(treasure: Dictionary, pos: Vector2, locked: bool) -> void:
	if treasure.is_empty():
		return
	pending_chest_reward = treasure.duplicate()
	pending_chest_reward_pos = pos
	pending_chest_reward_locked = locked
	chest_reward_open = true
	chest_reward_time = 0.0
	choice_open = true
	_update_chest_reward_panel()
	chest_reward_panel.visible = true
	chest_reward_panel.scale = Vector2(0.90, 0.90)
	chest_reward_panel.pivot_offset = chest_reward_panel.custom_minimum_size * 0.5
	_burst(pos, _treasure_color(String(treasure.get("rarity", "common"))), 28 if locked else 18)
	_spawn_ring_fx(pos, 14.0, _treasure_color(String(treasure.get("rarity", "common"))), 132.0 if locked else 96.0, 0.28, 5.0, "rune")
	var tween := create_tween()
	tween.tween_property(chest_reward_panel, "scale", Vector2.ONE, 0.16).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _update_chest_reward_panel() -> void:
	if chest_reward_panel.get_child_count() == 0 or pending_chest_reward.is_empty():
		return
	var box := chest_reward_panel.get_child(0) as VBoxContainer
	var rarity_label := box.get_node("Rarity") as Label
	var title := box.get_node("Title") as Label
	var desc := box.get_node("Desc") as Label
	var stage := box.get_node("Stage") as Control
	var chest_icon := stage.get_node("ChestIcon") as TextureRect
	var relic_frame := stage.get_node("RelicFrame") as PanelContainer
	var relic_icon := stage.get_node("RelicFrame/RelicMargin/RelicIcon") as TextureRect
	var relic_id := String(pending_chest_reward.get("id", ""))
	var rarity := String(pending_chest_reward.get("rarity", "common"))
	var rarity_color := _treasure_color(rarity)
	rarity_label.text = rarity.to_upper()
	rarity_label.add_theme_color_override("font_color", rarity_color.lightened(0.20))
	title.text = String(pending_chest_reward.get("title", "レリック"))
	desc.text = String(pending_chest_reward.get("desc", ""))
	chest_icon.texture = interactable_textures.get("chest", null) as Texture2D
	relic_icon.texture = relic_icon_textures.get(relic_id, null) as Texture2D
	relic_frame.add_theme_stylebox_override("panel", _panel_style(Color(rarity_color.r * 0.20, rarity_color.g * 0.18, rarity_color.b * 0.18, 0.92), rarity_color.lightened(0.12), 3, 2, 8.0))
	chest_reward_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.006, 0.026, 0.030, 0.98), rarity_color.lightened(0.08), 3, 2, 22.0))


func _take_chest_reward() -> void:
	if pending_chest_reward.is_empty():
		chest_reward_open = false
		choice_open = false
		chest_reward_panel.visible = false
		return
	var treasure := pending_chest_reward.duplicate()
	var pos := pending_chest_reward_pos
	_apply_treasure(treasure, pos)
	if rng.randf() < float(stats["luck"]):
		_spawn_loot_item(pos, "gold", rng.randi_range(4, 9), 34.0)
	backpack["relics"] += 1
	status_label.text = "%s found. %s" % [treasure["title"], treasure["desc"]]
	_burst(pos, _treasure_color(String(treasure["rarity"])), 22 if pending_chest_reward_locked else 14)
	chest_reward_open = false
	choice_open = false
	chest_reward_panel.visible = false
	pending_chest_reward.clear()
	if xp >= xp_next:
		_gain_xp(0)
	_update_ui()


func _drop_chest_items(pos: Vector2, locked: bool) -> void:
	var rolls := 7 if locked else 4
	for i in rolls:
		var kind := "gold"
		var value := rng.randi_range(3, 8)
		var roll := rng.randf()
		if roll > 0.86:
			kind = "meat"
			value = 24
		elif roll > 0.75:
			kind = "magnet"
			value = 1
		elif roll > 0.58:
			kind = "keys"
			value = 1
		elif roll > 0.42:
			kind = "ore"
			value = rng.randi_range(1, 3)
		elif locked and roll > 0.24:
			kind = "relics"
			value = 1
		_spawn_loot_item(pos, kind, value, 46.0)
	status_label.text = "Chest dropped items."


func _merchant_relic_price(rarity: String) -> int:
	match rarity:
		"common":
			return 55
		"rare":
			return 110
		"epic":
			return 210
		"legendary":
			return 360
	return 80


func _merchant_relic_current_price(rarity: String) -> int:
	return _merchant_relic_price(rarity) + merchant_purchase_count * MERCHANT_PRICE_STEP


func _buy_merchant_relic(interactable: Dictionary, pos: Vector2) -> bool:
	var price := int(interactable.get("price", 90))
	if int(backpack["gold"]) < price:
		status_label.text = "商人: ゴールドが足りない。必要 %dG" % price
		_burst(pos, Color(0.95, 0.18, 0.18, 0.42), 8)
		return false
	var relic_id := String(interactable.get("relic_id", ""))
	var treasure := _treasure_by_id(relic_id)
	if treasure.is_empty():
		treasure = _roll_treasure(false)
	backpack["gold"] -= price
	_apply_treasure(treasure, pos)
	backpack["relics"] += 1
	status_label.text = "商人から購入: %s  -%dG" % [String(treasure["title"]), price]
	_burst(pos, _treasure_color(String(treasure["rarity"])), 18)
	return true


func _open_merchant_choices(pos: Vector2, index: int) -> void:
	merchant_choice_pos = pos
	merchant_choice_index = index
	merchant_choice_open = true
	merchant_choice_time = 0.0
	choice_open = true
	offered_merchant_relics = _roll_altar_relic_choices()
	_update_merchant_panel()
	merchant_panel.visible = true
	merchant_panel.scale = Vector2(0.94, 0.94)
	merchant_panel.pivot_offset = merchant_panel.custom_minimum_size * 0.5
	_burst(pos, Color(1.0, 0.72, 0.20, 0.70), 22)
	_spawn_ring_fx(pos, 14.0, Color(1.0, 0.72, 0.20, 0.60), 112.0, 0.30, 4.8, "rune")
	var tween := create_tween()
	tween.tween_property(merchant_panel, "scale", Vector2.ONE, 0.14).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _update_merchant_panel() -> void:
	if merchant_panel.get_child_count() == 0:
		return
	var box := merchant_panel.get_child(0) as VBoxContainer
	var subtitle := box.get_node("Subtitle") as Label
	subtitle.text = "所持 %dG / 購入ごとに価格 +%dG" % [int(backpack["gold"]), MERCHANT_PRICE_STEP]
	for i in 3:
		var button := box.get_node("Relic%d" % i) as Button
		if i >= offered_merchant_relics.size():
			button.visible = false
			continue
		button.visible = true
		var treasure := offered_merchant_relics[i]
		var rarity := String(treasure.get("rarity", "common"))
		var rarity_color := _treasure_color(rarity)
		var price := _merchant_relic_current_price(rarity)
		var can_buy := int(backpack["gold"]) >= price
		var bg := Color(0.030, 0.020, 0.012, 0.96) if can_buy else Color(0.030, 0.024, 0.022, 0.76)
		button.disabled = false
		button.add_theme_stylebox_override("normal", _panel_style(bg, rarity_color.lightened(0.05) if can_buy else Color(0.36, 0.32, 0.30, 0.90), 2, 2))
		button.add_theme_stylebox_override("hover", _panel_style(bg.lightened(0.08), rarity_color.lightened(0.22), 3, 2))
		button.add_theme_stylebox_override("pressed", _panel_style(bg.darkened(0.05), rarity_color, 3, 2))
		var icon_frame := button.get_node("Card/Row/IconFrame") as PanelContainer
		var icon := button.get_node("Card/Row/IconFrame/IconMargin/Icon") as TextureRect
		var name_label := button.get_node("Card/Row/TextColumn/Header/Name") as Label
		var rarity_label := button.get_node("Card/Row/TextColumn/Header/Rarity") as Label
		var desc := button.get_node("Card/Row/TextColumn/Desc") as Label
		var price_label := button.get_node("Card/Row/Price") as Label
		var relic_id := String(treasure.get("id", ""))
		icon_frame.add_theme_stylebox_override("panel", _panel_style(Color(rarity_color.r * 0.20, rarity_color.g * 0.18, rarity_color.b * 0.18, 0.92), rarity_color.lightened(0.12), 3, 2, 8.0))
		icon.texture = relic_icon_textures.get(relic_id, null) as Texture2D
		name_label.text = String(treasure.get("title", relic_id))
		rarity_label.text = rarity.to_upper()
		rarity_label.add_theme_color_override("font_color", rarity_color.lightened(0.20))
		desc.text = String(treasure.get("desc", ""))
		price_label.text = "%dG" % price
		price_label.add_theme_color_override("font_color", Color(1.0, 0.82, 0.24) if can_buy else Color(1.0, 0.36, 0.30))


func _choose_merchant_relic(index: int) -> void:
	if index < 0 or index >= offered_merchant_relics.size():
		return
	var treasure := offered_merchant_relics[index]
	var rarity := String(treasure.get("rarity", "common"))
	var price := _merchant_relic_current_price(rarity)
	if int(backpack["gold"]) < price:
		status_label.text = "商人: ゴールドが足りない。必要 %dG" % price
		_burst(merchant_choice_pos, Color(0.95, 0.18, 0.18, 0.42), 8)
		_update_merchant_panel()
		return
	backpack["gold"] -= price
	merchant_purchase_count += 1
	_apply_treasure(treasure, merchant_choice_pos)
	backpack["relics"] += 1
	status_label.text = "商人から購入: %s  -%dG" % [String(treasure.get("title", "レリック")), price]
	_burst(merchant_choice_pos, _treasure_color(rarity), 18)
	if merchant_choice_index >= 0 and merchant_choice_index < interactables.size():
		interactables.remove_at(merchant_choice_index)
	merchant_choice_open = false
	choice_open = false
	merchant_panel.visible = false
	offered_merchant_relics.clear()
	merchant_choice_index = -1
	if xp >= xp_next:
		_gain_xp(0)
	_update_ui()


func _break_pot(pos: Vector2) -> void:
	var center := player_pos
	var needed_gold := maxi(1, _chest_open_cost())
	var needed_xp := maxi(1, xp_next - xp)
	var gold_total := maxi(2, int(round(float(needed_gold) * rng.randf_range(0.18, 0.34))))
	var xp_total := maxi(1, int(round(float(needed_xp) * rng.randf_range(0.12, 0.24))))
	var gold_count := clampi(rng.randi_range(3, 6), 1, gold_total)
	var remaining_gold := gold_total
	for i in gold_count:
		var drops_left := gold_count - i
		var value := remaining_gold if drops_left <= 0 else rng.randi_range(1, maxi(1, remaining_gold - drops_left))
		remaining_gold -= value
		_spawn_loot_item(center, "gold", value, 58.0)
	var xp_count := clampi(rng.randi_range(2, 5), 1, xp_total)
	var remaining_xp := xp_total
	for i in xp_count:
		var drops_left := xp_count - i
		var value := remaining_xp if drops_left <= 0 else rng.randi_range(1, maxi(1, remaining_xp - drops_left))
		remaining_xp -= value
		_spawn_loot_item(center, "xp", value, 64.0)
	status_label.text = "壺からコインと経験値が散らばった。"
	_burst(pos, Color(0.74, 0.62, 0.42, 0.64), 10)
	_burst(center, Color(1.0, 0.78, 0.22, 0.42), 12)


func _spawn_loot_item(pos: Vector2, kind: String, value: int, spread: float) -> void:
	_add_loot_item(pos, kind, value, spread)


func _apply_random_treasure(pos: Vector2, locked: bool) -> void:
	var treasure := _roll_treasure(locked)
	_apply_treasure(treasure, pos)
	if rng.randf() < float(stats["luck"]):
		_spawn_loot_item(pos, "gold", rng.randi_range(4, 9), 34.0)
	backpack["relics"] += 1
	status_label.text = "%s found. %s" % [treasure["title"], treasure["desc"]]
	_burst(pos, Color(0.88, 0.42, 1.0, 0.74), 22 if locked else 14)


func _roll_treasure(locked: bool) -> Dictionary:
	var common_weight := 48 if not locked else 28
	var rare_weight := 32 if not locked else 34
	var epic_weight := 16 if not locked else 26
	var legendary_weight := 4 if not locked else 12
	var roll := rng.randi_range(1, common_weight + rare_weight + epic_weight + legendary_weight)
	var target := "common"
	if roll > common_weight + rare_weight + epic_weight:
		target = "legendary"
	elif roll > common_weight + rare_weight:
		target = "epic"
	elif roll > common_weight:
		target = "rare"
	var pool: Array[Dictionary] = []
	for entry in TREASURE_DEFS:
		var treasure := entry as Dictionary
		if String(treasure["rarity"]) == target:
			pool.append(treasure)
	if pool.is_empty():
		pool = TREASURE_DEFS.duplicate()
	pool.shuffle()
	return pool[0]


func _apply_treasure(treasure: Dictionary, pos: Vector2) -> void:
	var id := String(treasure["id"])
	treasure_counts[id] = int(treasure_counts.get(id, 0)) + 1
	acquired_relics.append(id)
	match id:
		"key":
			stats["key_open_chance"] += 0.10
			backpack["keys"] += 1
		"wrench", "beacon":
			stats["luck"] += 0.05
			_spawn_interactable("altar", _random_world_pos_near_player(260.0, 520.0))
		"cheese":
			stats["poison_chance"] += 0.40
		"gym_sauce":
			stats["damage"] += 4
		"time_bracelet":
			stats["xp_gain"] += 0.08
		"boss_buster":
			stats["boss_damage"] += 0.15
		"clover":
			stats["luck"] += 0.075
		"golden_glove":
			stats["gold_gain"] += 0.15
		"oats":
			max_hp += 25
			player_hp += 25
		"turbo_socks", "feather", "coward_cape", "golden_sneakers":
			stats["speed"] += 42
		"tactical_glasses":
			stats["crit_chance"] += 0.05
		"battery":
			stats["attack_rate"] = max(0.12, float(stats["attack_rate"]) * 0.92)
		"forbidden_juice":
			stats["crit_chance"] += 0.10
		"cursed_doll":
			stats["damage"] += 10
			if not invincible_mode:
				_damage_player(maxi(1, int(max_hp * 0.15)))
		"ice_crystal", "ice_cube":
			stats["frost_chance"] += 0.075
		"skull_egg":
			stats["difficulty"] += 0.07
		"ghost", "bob":
			stats["drone_count"] += 1
			stats["drone_damage"] += 3
		"cactus", "spiked_shield":
			stats["thorns"] += 8
		"burger":
			stats["burger_chance"] += 0.02
		"medkit":
			stats["regen"] += 3
		"red_credit_card":
			stats["damage"] += 3
		"backpack", "anvil":
			stats["projectiles"] += 1
		"echo_shard", "fragmented_knowledge":
			stats["bonus_xp_chance"] += 0.12
		"idle_juice":
			stats["damage"] += 8
		"unstable_transfusion", "bloody_cleaver":
			stats["lifesteal_chance"] += 0.06
		"golden_shield":
			stats["shield"] += 20
			player_shield = int(stats["shield"])
		"kevin":
			stats["damage"] += 12
			_spawn_enemy_at("elite", player_pos + Vector2(160.0, -220.0), true)
		"thunder_mitt", "electric_plug", "lightning_orb":
			stats["lightning_chance"] += 0.10
			stats["lightning_targets"] += 1
		"beer":
			stats["damage"] += 8
			max_hp = maxi(30, int(max_hp * 0.95))
			player_hp = mini(player_hp, max_hp)
		"phantom_shroud":
			stats["evasion"] += 0.08
			stats["speed"] += 25
		"knuckle_duster":
			stats["near_damage"] += 0.20
		"demon_blade", "vampire_crystal", "chonk_plate":
			stats["lifesteal_chance"] += 0.12
			max_hp += 40
			player_hp += 20
		"demon_blood":
			stats["kill_damage_gain"] += 0.01
		"moldy_glove", "poison_barrel":
			stats["poison_chance"] += 0.20
		"muscle_ring":
			stats["damage"] += int(max_hp / 100.0) * 6
		"green_credit_card":
			stats["luck"] += 0.08
		"grandma_tonic", "spicy_meatball", "power_glove":
			stats["explode_chance"] += 0.10
		"cursed_gravy":
			stats["difficulty"] += 0.10
			stats["damage"] += 9
			max_hp = maxi(30, int(max_hp * 0.8))
			player_hp = mini(player_hp, max_hp)
		"mirror":
			stats["evasion"] += 0.08
			stats["thorns"] += 12
		"demon_soul":
			stats["kill_damage_gain"] += 0.01
		"slurp_glove":
			stats["lifesteal_chance"] += 0.10
			stats["explode_chance"] += 0.04
		"scarf", "eagle_claw":
			stats["damage"] += 6
		"roller_blades":
			stats["speed"] += 35
			stats["attack_rate"] = max(0.12, float(stats["attack_rate"]) * 0.92)
		"loose_cannon", "soul_harvester", "energy_core":
			stats["projectiles"] += 1
			stats["damage"] += 5
		"quin_mask":
			stats["thorns"] += 8
			stats["explode_chance"] += 0.05
		"gas_mask":
			stats["armor"] += 2
			stats["poison_chance"] += 0.10
		"gamer_goggles", "speed_boy":
			stats["low_hp_damage"] += 0.35
		"lamp":
			stats["explode_chance"] += 0.05
			stats["lightning_chance"] += 0.05
			stats["poison_chance"] += 0.10
		"the_world":
			stats["evasion"] += 0.15
			player_hp = max(player_hp, 1)
		"suction_magnet":
			stats["magnet"] += 220.0
		"big_bonk":
			stats["bonk_chance"] += 0.02
		"joe_dagger":
			stats["execute_chance"] += 0.01
		"dragon_fire":
			stats["explode_chance"] += 0.08
		"holy_book":
			max_hp += 100
			player_hp += 100
			stats["regen"] += 5
		"giant_fork":
			stats["crit_chance"] += 0.14
	_burst(pos, _treasure_color(String(treasure["rarity"])), 16)


func _treasure_color(rarity: String) -> Color:
	if rarity == "legendary":
		return Color(1.0, 0.66, 0.08, 0.82)
	if rarity == "epic":
		return Color(0.78, 0.22, 1.0, 0.78)
	if rarity == "rare":
		return Color(0.28, 0.72, 1.0, 0.72)
	return Color(0.76, 0.92, 0.72, 0.65)


func _use_curse_altar(pos: Vector2) -> void:
	_open_altar_relic_choices(pos)


func _open_altar_relic_choices(pos: Vector2) -> void:
	altar_relic_choice_pos = pos
	altar_relic_choice_open = true
	altar_relic_choice_time = 0.0
	choice_open = true
	offered_altar_relics = _roll_altar_relic_choices()
	_update_altar_relic_panel()
	altar_relic_panel.visible = true
	altar_relic_panel.scale = Vector2(0.94, 0.94)
	altar_relic_panel.pivot_offset = altar_relic_panel.custom_minimum_size * 0.5
	_burst(pos, Color(0.78, 0.16, 1.0, 0.75), 30)
	_spawn_ring_fx(pos, 16.0, Color(0.78, 0.16, 1.0, 0.70), 128.0, 0.34, 5.5, "rune")
	var tween := create_tween()
	tween.tween_property(altar_relic_panel, "scale", Vector2.ONE, 0.14).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _roll_altar_relic_choices() -> Array[Dictionary]:
	var choices: Array[Dictionary] = []
	var used := {}
	var attempts := 0
	while choices.size() < 3 and attempts < 24:
		attempts += 1
		var treasure := _roll_treasure(false)
		var relic_id := String(treasure.get("id", ""))
		if used.has(relic_id):
			continue
		used[relic_id] = true
		choices.append(treasure)
	if choices.size() < 3:
		var pool := TREASURE_DEFS.duplicate()
		pool.shuffle()
		for entry in pool:
			var treasure := entry as Dictionary
			var relic_id := String(treasure.get("id", ""))
			if used.has(relic_id):
				continue
			used[relic_id] = true
			choices.append(treasure)
			if choices.size() >= 3:
				break
	return choices


func _update_altar_relic_panel() -> void:
	if altar_relic_panel.get_child_count() == 0:
		return
	var box := altar_relic_panel.get_child(0) as VBoxContainer
	for i in 3:
		var button := box.get_node("Relic%d" % i) as Button
		if i >= offered_altar_relics.size():
			button.visible = false
			continue
		button.visible = true
		var treasure := offered_altar_relics[i]
		var rarity := String(treasure.get("rarity", "common"))
		var rarity_color := _treasure_color(rarity)
		button.add_theme_stylebox_override("normal", _panel_style(Color(0.020, 0.012, 0.030, 0.96), rarity_color.lightened(0.05), 2, 2))
		button.add_theme_stylebox_override("hover", _panel_style(Color(0.045, 0.024, 0.065, 0.98), rarity_color.lightened(0.22), 3, 2))
		button.add_theme_stylebox_override("pressed", _panel_style(Color(0.014, 0.006, 0.026, 0.98), rarity_color, 3, 2))
		var icon_frame := button.get_node("Card/Row/IconFrame") as PanelContainer
		var icon := button.get_node("Card/Row/IconFrame/IconMargin/Icon") as TextureRect
		var name_label := button.get_node("Card/Row/TextColumn/Header/Name") as Label
		var rarity_label := button.get_node("Card/Row/TextColumn/Header/Rarity") as Label
		var desc := button.get_node("Card/Row/TextColumn/Desc") as Label
		var relic_id := String(treasure.get("id", ""))
		icon_frame.add_theme_stylebox_override("panel", _panel_style(Color(rarity_color.r * 0.20, rarity_color.g * 0.18, rarity_color.b * 0.18, 0.92), rarity_color.lightened(0.12), 3, 2, 8.0))
		icon.texture = relic_icon_textures.get(relic_id, null) as Texture2D
		name_label.text = String(treasure.get("title", relic_id))
		rarity_label.text = rarity.to_upper()
		rarity_label.add_theme_color_override("font_color", rarity_color.lightened(0.20))
		desc.text = String(treasure.get("desc", ""))


func _choose_altar_relic(index: int) -> void:
	if index < 0 or index >= offered_altar_relics.size():
		return
	var treasure := offered_altar_relics[index]
	_apply_treasure(treasure, altar_relic_choice_pos)
	backpack["relics"] += 1
	status_label.text = "祭壇から獲得: %s" % String(treasure.get("title", "レリック"))
	_burst(altar_relic_choice_pos, _treasure_color(String(treasure.get("rarity", "common"))), 22)
	altar_relic_choice_open = false
	choice_open = false
	altar_relic_panel.visible = false
	offered_altar_relics.clear()
	if xp >= xp_next:
		_gain_xp(0)
	_update_ui()


func _apply_random_weapon_boost() -> void:
	var weapon := _random_auto_combat_weapon_id()
	_track_weapon_upgrade(weapon)
	status_label.text = "Cursed machine: %s Lv%d." % [_weapon_title(weapon), int(weapon_levels.get(weapon, 0))]


func _bag_count() -> int:
	return int(backpack["gold"]) + int(backpack["relics"]) + int(backpack["keys"]) + int(backpack["ore"])


func _bag_value() -> int:
	return int(backpack["gold"]) + int(backpack["relics"]) * 18 + int(backpack["keys"]) * 9 + int(backpack["ore"]) * 4


func _level_up() -> void:
	xp -= xp_next
	player_level += 1
	xp_next += 6
	_open_upgrade_choices()


func _open_upgrade_choices() -> void:
	choice_open = true
	_start_level_up_presentation()
	offered_upgrades = _roll_upgrades()
	var box := choice_panel.get_child(0) as VBoxContainer
	var title := box.get_node("Title") as Label
	var subtitle := box.get_node("Subtitle") as Label
	title.text = "報酬を選択"
	subtitle.text = "Lv%d到達。1つ選んで強化。" % player_level
	subtitle.visible = true
	for i in 3:
		var button := box.get_node("Upgrade%d" % i) as Button
		if i >= offered_upgrades.size():
			button.visible = false
			continue
		button.visible = true
		var upgrade := offered_upgrades[i]
		_apply_upgrade_button_style(button, upgrade)
		_update_upgrade_card_button(button, upgrade)
	choice_panel.visible = true
	choice_panel.scale = Vector2(0.95, 0.95)
	choice_panel.pivot_offset = choice_panel.custom_minimum_size * 0.5
	var tween := create_tween()
	tween.tween_property(choice_panel, "scale", Vector2.ONE, 0.14).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	_update_ui()


func _start_level_up_presentation() -> void:
	level_up_fx_time = 0.0
	_burst(player_pos, Color(1.0, 0.92, 0.24, 0.82), 46)
	_spawn_ring_fx(player_pos, 28.0, Color(1.0, 0.9, 0.24, 0.74), 190.0, 0.42, 8.0, "rune")


func _apply_upgrade_button_style(button: Button, upgrade: Dictionary) -> void:
	var rarity := String(upgrade.get("rarity", "normal"))
	var border := _upgrade_rarity_color(rarity)
	button.text = ""
	button.icon = null
	var bg := _upgrade_rarity_card_color(rarity)
	button.add_theme_stylebox_override("normal", _panel_style(bg, border, 3, 1))
	button.add_theme_stylebox_override("hover", _panel_style(bg.lightened(0.08), border.lightened(0.18), 4, 1))
	button.add_theme_stylebox_override("pressed", _panel_style(bg.darkened(0.08), border, 4, 1))


func _update_upgrade_card_button(button: Button, upgrade: Dictionary) -> void:
	var card := button.get_node("Card") as MarginContainer
	var row := card.get_node("Row") as HBoxContainer
	var left := row.get_node("IconColumn") as VBoxContainer
	var right := row.get_node("TextColumn") as VBoxContainer
	var rarity := String(upgrade.get("rarity", "normal"))
	var rarity_color := _upgrade_rarity_color(rarity)
	var rarity_label := left.get_node("Rarity") as Label
	var icon_frame := left.get_node("IconFrame") as PanelContainer
	var icon := icon_frame.get_node("IconMargin/Icon") as TextureRect
	var header := right.get_node("Header") as HBoxContainer
	var name_label := header.get_node("Name") as Label
	var state_label := header.get_node("State") as Label
	var effect := right.get_node("Effect") as RichTextLabel
	rarity_label.text = _upgrade_rarity_label(rarity)
	rarity_label.add_theme_color_override("font_color", rarity_color)
	icon_frame.add_theme_stylebox_override("panel", _panel_style(_upgrade_rarity_fill_color(rarity), rarity_color, 3, 1))
	icon.texture = _upgrade_icon(upgrade)
	name_label.text = String(upgrade.get("title", ""))
	state_label.text = _upgrade_state_text(upgrade)
	effect.text = _upgrade_effect_bbcode(upgrade)


func _upgrade_card_text(upgrade: Dictionary) -> String:
	var rarity := _upgrade_rarity_label(String(upgrade.get("rarity", "normal")))
	var category := String(upgrade.get("category", ""))
	var title := String(upgrade.get("title", ""))
	var state := _upgrade_state_text(upgrade)
	return "%s    %s    %s\n%s" % [rarity, title, state, _upgrade_effect_preview(upgrade)]


func _upgrade_state_text(upgrade: Dictionary) -> String:
	if String(upgrade.get("category", "")) == "武器":
		var weapon := String(upgrade.get("weapon", ""))
		var level := int(weapon_levels.get(weapon, 0))
		if level <= 0:
			return "新規 %d/%d" % [_active_weapon_count(), _current_weapon_slots()]
		return "Lv%d -> %d" % [level, level + 1]
	if String(upgrade.get("category", "")) == "チャーム":
		var charm := String(upgrade.get("key", ""))
		var charm_level := int(charm_levels.get(charm, 0))
		if charm_level <= 0:
			return "新規 %d/%d" % [_active_charm_count(), _current_charm_slots()]
		return "Lv%d -> %d" % [charm_level, charm_level + 1]
	return "強化"


func _upgrade_effect_preview(upgrade: Dictionary) -> String:
	var category := String(upgrade.get("category", ""))
	if category == "武器":
		return _weapon_upgrade_preview(upgrade)
	var key := String(upgrade.get("key", ""))
	var amount := _upgrade_amount(upgrade)
	return "%s: %s -> %s" % [_upgrade_stat_label(key), _stat_value_text(key, _upgrade_current_value(key)), _stat_value_text(key, _upgrade_current_value(key) + amount)]


func _upgrade_effect_bbcode(upgrade: Dictionary) -> String:
	var category := String(upgrade.get("category", ""))
	if category == "武器":
		var weapon := String(upgrade.get("weapon", ""))
		var stat := String(upgrade.get("stat", ""))
		var amount := float(upgrade.get("weapon_amount", 0.0))
		return "%s\n%s: %s -> [color=#6dff77]%s[/color]" % [
			_weapon_effect(weapon),
			_upgrade_stat_label(stat),
			_weapon_bonus_value_text(stat, _weapon_stat_bonus(weapon, stat)),
			_weapon_bonus_value_text(stat, _weapon_stat_bonus(weapon, stat) + amount),
		]
	var key := String(upgrade.get("key", ""))
	var amount := _upgrade_amount(upgrade)
	return "%s: %s -> [color=#6dff77]%s[/color]" % [
		_upgrade_stat_label(key),
		_stat_value_text(key, _upgrade_current_value(key)),
		_stat_value_text(key, _upgrade_current_value(key) + amount),
	]


func _upgrade_current_value(key: String) -> float:
	if key == "cooldown_tome":
		return (1.0 - float(stats.get("skill_cooldown", 1.0))) * 100.0
	if key == "size_tome":
		return (float(stats.get("area_size", 1.0)) - 1.0) * 100.0
	if key == "cursed_tome":
		return (float(stats.get("xp_gain", 1.0)) - 1.0) * 100.0
	if key == "chaos_tome":
		return 0.0
	if key == "golden_tome":
		return (float(stats.get("gold_gain", 1.0)) - 1.0) * 100.0
	if key == "xp_gain" or key == "luck" or key == "crit_chance" or key == "projectile_speed" or key == "lifesteal_chance" or key == "gold_gain" or key == "evasion" or key == "duration" or key == "knockback":
		return (float(stats.get(key, 0.0)) - (1.0 if key == "xp_gain" or key == "projectile_speed" or key == "gold_gain" or key == "duration" or key == "knockback" else 0.0)) * 100.0
	return float(stats.get(key, 0.0))


func _stat_value_text(key: String, value: float) -> String:
	if key == "damage" or key == "projectiles" or key == "armor" or key == "shield" or key == "thorns" or key == "regen" or key == "max_hp":
		return "%d" % int(round(value))
	return "%d%%" % int(round(value))


func _weapon_bonus_value_text(key: String, value: float) -> String:
	if key == "projectiles" or key == "pierce":
		return "+%d" % int(round(value))
	return "+%d%%" % int(round(value * 100.0))


func _upgrade_stat_label(key: String) -> String:
	match key:
		"xp_gain":
			return "XP"
		"luck":
			return "運"
		"cursed_tome":
			return "報酬"
		"chaos_tome":
			return "ランダム"
		"damage":
			return "ダメージ"
		"cooldown":
			return "攻撃間隔"
		"crit_chance":
			return "クリティカル"
		"cooldown_tome":
			return "攻撃速度"
		"size_tome":
			return "サイズ"
		"armor":
			return "アーマー"
		"range":
			return "範囲"
		"size":
			return "大きさ"
		"projectile_speed":
			return "弾速"
		"pierce":
			return "貫通"
		"status_chance":
			return "状態異常"
		"thorns":
			return "反撃"
		"lifesteal_chance":
			return "吸血"
		"shield":
			return "シールド"
		"gold_gain":
			return "ゴールド"
		"projectiles":
			return "弾数"
		"golden_tome":
			return "金運"
		"magnet":
			return "回収範囲"
		"evasion":
			return "回避"
		"regen":
			return "リジェネ"
		"max_hp":
			return "最大HP"
		"speed":
			return "移動速度"
		"knockback":
			return "ノックバック"
		"duration":
			return "持続時間"
	return key


func _upgrade_rarity_label(rarity: String) -> String:
	match rarity:
		"uncommon":
			return "Uncommon"
		"common":
			return "Common"
		"epic":
			return "Epic"
		"legendary":
			return "Legendary"
	return "Normal"


func _upgrade_rarity_color(rarity: String) -> Color:
	match rarity:
		"uncommon":
			return Color(0.16, 0.64, 1.0)
		"common":
			return Color(0.22, 0.86, 0.34)
		"epic":
			return Color(0.95, 0.16, 0.18)
		"legendary":
			return Color(1.0, 0.76, 0.12)
	return Color(0.55, 0.58, 0.62)


func _upgrade_rarity_fill_color(rarity: String) -> Color:
	var color := _upgrade_rarity_color(rarity)
	return Color(color.r * 0.26, color.g * 0.34, color.b * 0.30, 0.84)


func _upgrade_rarity_card_color(rarity: String) -> Color:
	match rarity:
		"uncommon":
			return Color(0.0, 0.035, 0.075, 0.96)
		"common":
			return Color(0.0, 0.095, 0.035, 0.96)
		"epic":
			return Color(0.10, 0.0, 0.012, 0.96)
		"legendary":
			return Color(0.12, 0.105, 0.0, 0.96)
	return Color(0.006, 0.020, 0.018, 0.96)


func _upgrade_rarity_multiplier(rarity: String) -> float:
	match rarity:
		"uncommon":
			return 1.18
		"common":
			return 1.35
		"epic":
			return 1.9
		"legendary":
			return 2.35
	return 1.0


func _roll_upgrade_rarity() -> String:
	var roll := rng.randf()
	if roll > 0.97:
		return "legendary"
	if roll > 0.82:
		return "epic"
	if roll > 0.48:
		return "common"
	if roll > 0.24:
		return "uncommon"
	return "normal"


func _upgrade_amount(upgrade: Dictionary) -> float:
	return float(upgrade.get("amount", 1.0)) * _upgrade_rarity_multiplier(String(upgrade.get("rarity", "normal")))


func _upgrade_icon(upgrade: Dictionary) -> Texture2D:
	var category := String(upgrade.get("category", ""))
	if category == "武器":
		var weapon_id := String(upgrade.get("weapon", ""))
		return weapon_icon_textures.get(weapon_id, null) as Texture2D
	if category == "チャーム":
		var charm_id := String(upgrade.get("key", ""))
		return charm_icon_textures.get(charm_id, null) as Texture2D
	return null


func _roll_upgrades() -> Array[Dictionary]:
	var weapon_pool := _weapon_upgrade_pool()
	var tome_pool := _tome_upgrade_pool()
	var offered: Array[Dictionary] = []
	if weapon_pool.is_empty() and tome_pool.is_empty():
		return offered
	weapon_pool.shuffle()
	tome_pool.shuffle()
	if not weapon_pool.is_empty():
		offered.append(weapon_pool[0])
	if not tome_pool.is_empty():
		offered.append(tome_pool[0])
	var mixed := weapon_pool.slice(1) + tome_pool.slice(1)
	mixed.shuffle()
	for upgrade in mixed:
		if offered.size() >= 3:
			break
		offered.append(upgrade)
	offered.shuffle()
	for i in offered.size():
		offered[i]["rarity"] = _roll_upgrade_rarity()
		if String(offered[i].get("category", "")) == "武器":
			_roll_weapon_upgrade_stat(offered[i])
	return offered


func _weapon_upgrade_pool() -> Array[Dictionary]:
	var pool: Array[Dictionary] = []
	var can_add_weapon := _active_weapon_count() < _current_weapon_slots()
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		var weapon_id := String(def["id"])
		if HIDDEN_WEAPON_IDS.has(weapon_id):
			continue
		if int(weapon_levels.get(weapon_id, 0)) <= 0 and not can_add_weapon:
			continue
		pool.append({
			"category": "武器",
			"title": String(def["title"]),
			"desc": _weapon_choice_desc(weapon_id),
			"key": "weapon_%s" % weapon_id,
			"weapon": weapon_id,
		})
	return pool


func _roll_weapon_upgrade_stat(upgrade: Dictionary) -> void:
	var weapon := String(upgrade.get("weapon", ""))
	var options := WEAPON_UPGRADE_STAT_OPTIONS.get(weapon, []) as Array
	if options.is_empty():
		upgrade["stat"] = "damage"
	else:
		upgrade["stat"] = String(options[rng.randi_range(0, options.size() - 1)])
	var stat := String(upgrade["stat"])
	var rarity := String(upgrade.get("rarity", "normal"))
	var rarity_ranges := WEAPON_STAT_UPGRADE_RANGES.get(stat, {}) as Dictionary
	var range := rarity_ranges.get(rarity, rarity_ranges.get("normal", [0.05, 0.1])) as Array
	if stat == "projectiles" or stat == "pierce":
		upgrade["weapon_amount"] = float(rng.randi_range(int(range[0]), int(range[1])))
	else:
		upgrade["weapon_amount"] = rng.randf_range(float(range[0]), float(range[1]))


func _weapon_upgrade_preview(upgrade: Dictionary) -> String:
	var weapon := String(upgrade.get("weapon", ""))
	var stat := String(upgrade.get("stat", ""))
	var amount := float(upgrade.get("weapon_amount", 0.0))
	if stat.is_empty():
		return _weapon_choice_desc(weapon)
	return "%s: %s -> %s" % [
		_upgrade_stat_label(stat),
		_weapon_bonus_value_text(stat, _weapon_stat_bonus(weapon, stat)),
		_weapon_bonus_value_text(stat, _weapon_stat_bonus(weapon, stat) + amount),
	]


func _weapon_choice_desc(weapon: String) -> String:
	var level := int(weapon_levels.get(weapon, 0))
	var effect := _weapon_effect(weapon)
	if level <= 0:
		return "%s / 新規入手" % effect
	return "%s / Lv%d -> Lv%d" % [effect, level, level + 1]


func _weapon_title(weapon: String) -> String:
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		if String(def["id"]) == weapon:
			return String(def["title"])
	return weapon


func _weapon_effect(weapon: String) -> String:
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		if String(def["id"]) == weapon:
			return String(def["desc"])
	return "武器を強化"


func _weapon_growth_candidates_text(weapon: String) -> String:
	var keys := WEAPON_UPGRADE_STAT_OPTIONS.get(weapon, []) as Array
	var labels: Array[String] = []
	for key in keys:
		labels.append(_upgrade_stat_label(String(key)))
	if labels.is_empty():
		return "未設定"
	return " / ".join(labels)


func _weapon_current_stats_text(weapon: String) -> String:
	var base := WEAPON_BASE_STATS.get(weapon, {}) as Dictionary
	var keys := WEAPON_UPGRADE_STAT_OPTIONS.get(weapon, []) as Array
	var lines: Array[String] = []
	for key_value in keys:
		var key := String(key_value)
		var base_text := ""
		if base.has(key):
			if key == "projectiles" or key == "pierce":
				base_text = "基礎 %d" % int(base[key])
			elif key == "cooldown":
				base_text = "基礎 %.2fs" % float(base[key])
			elif key == "projectile_speed" or key == "range":
				base_text = "基礎 %d" % int(round(float(base[key])))
			elif key == "size":
				base_text = "基礎 %.1fx" % float(base[key])
			elif key == "damage":
				base_text = "基礎 %.2fx" % float(base[key])
			else:
				base_text = "基礎 %s" % str(base[key])
		lines.append("%s %s %s" % [_upgrade_stat_label(key), base_text, _weapon_bonus_value_text(key, _weapon_stat_bonus(weapon, key))])
	return "\n".join(lines)


func _weapon_stat_bonus(weapon: String, stat_key: String) -> float:
	var weapon_bonuses := weapon_stat_bonuses.get(weapon, {}) as Dictionary
	return float(weapon_bonuses.get(stat_key, 0.0))


func _weapon_stat_multiplier(weapon: String, stat_key: String) -> float:
	var bonus := _weapon_stat_bonus(weapon, stat_key)
	if stat_key == "cooldown":
		return maxf(0.28, 1.0 - bonus)
	return 1.0 + bonus


func _weapon_scaled_damage(weapon: String, damage: int) -> int:
	var scaled := int(round(float(damage) * _weapon_stat_multiplier(weapon, "damage")))
	return maxi(1, scaled)


func _weapon_int_bonus(weapon: String, stat_key: String) -> int:
	return maxi(0, int(round(_weapon_stat_bonus(weapon, stat_key))))


func _apply_weapon_stat_bonus(weapon: String, stat_key: String, amount: float) -> void:
	if stat_key.is_empty() or amount <= 0.0:
		return
	if not weapon_stat_bonuses.has(weapon):
		weapon_stat_bonuses[weapon] = {}
	var weapon_bonuses := weapon_stat_bonuses[weapon] as Dictionary
	weapon_bonuses[stat_key] = float(weapon_bonuses.get(stat_key, 0.0)) + amount
	weapon_stat_bonuses[weapon] = weapon_bonuses


func _random_auto_combat_weapon_id() -> String:
	var visible_defs: Array[Dictionary] = []
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		if not HIDDEN_WEAPON_IDS.has(String(def["id"])):
			visible_defs.append(def)
	var index := rng.randi_range(0, visible_defs.size() - 1)
	var def := visible_defs[index] as Dictionary
	return String(def["id"])


func _test_add_next_weapon() -> void:
	if not test_mode:
		return
	var visible_defs: Array[Dictionary] = []
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var candidate := entry as Dictionary
		if not HIDDEN_WEAPON_IDS.has(String(candidate["id"])):
			visible_defs.append(candidate)
	if visible_defs.is_empty():
		return
	var def := visible_defs[test_weapon_index % visible_defs.size()] as Dictionary
	test_weapon_index += 1
	_track_weapon_upgrade(String(def["id"]))


func _test_all_weapons() -> void:
	if not test_mode:
		return
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		var weapon_id := String(def["id"])
		if HIDDEN_WEAPON_IDS.has(weapon_id):
			continue
		weapon_levels[weapon_id] = 3
		weapon_timers[weapon_id] = 0.0
	status_label.text = "Test Stage: 全武器をLv3にしました。"
	_refresh_test_weapon_panel()
	_burst(player_pos, Color(1.0, 0.84, 0.28, 0.72), 42)


func _test_spawn_pack() -> void:
	if not test_mode:
		return
	var offsets := [
		Vector2(-230.0, -150.0),
		Vector2(210.0, -150.0),
		Vector2(-260.0, 60.0),
		Vector2(260.0, 70.0),
		Vector2(-90.0, 230.0),
		Vector2(120.0, 240.0),
	]
	for i in offsets.size():
		var enemy_type := "shadow_cat" if i % 2 == 1 else "ghost"
		_spawn_enemy_at(enemy_type, player_pos + offsets[i])
	_spawn_enemy_at("elite", player_pos + Vector2(0.0, -330.0), true)
	status_label.text = "Test Stage: 雑魚とエリートを追加しました。"


func _test_spawn_boss() -> void:
	if not test_mode:
		return
	_spawn_enemy_at("dark_knight_boss", player_pos + Vector2(0.0, -520.0), true, true)
	boss_spawned = true
	status_label.text = "Test Stage: ボスを追加しました。"
	_burst(player_pos + Vector2(0.0, -360.0), Color(1.0, 0.28, 0.18, 0.72), 42)


func _test_open_level_up() -> void:
	if not test_mode or choice_open:
		return
	xp = xp_next
	_open_upgrade_choices()


func _toggle_test_weapon_panel() -> void:
	if not test_mode:
		return
	test_weapon_panel_open = not test_weapon_panel_open
	test_weapon_only_mode = test_weapon_panel_open
	if test_weapon_panel_open and test_weapon_selected_id.is_empty() and AUTO_COMBAT_WEAPON_DEFS.size() > 0:
		var def := AUTO_COMBAT_WEAPON_DEFS[0] as Dictionary
		test_weapon_selected_id = String(def["id"])
	if test_weapon_panel_open:
		_clear_test_weapon_combat_artifacts()
	_refresh_test_weapon_panel()
	_update_test_menu_visibility()


func _test_select_weapon_from_list(index: int) -> void:
	var list := _test_weapon_list()
	if list == null or index < 0 or index >= list.get_item_count():
		return
	test_weapon_selected_id = String(list.get_item_metadata(index))
	_clear_test_weapon_combat_artifacts()
	_refresh_test_weapon_panel()


func _test_change_selected_weapon_level(delta: int) -> void:
	if test_weapon_selected_id.is_empty():
		return
	var current := int(weapon_levels.get(test_weapon_selected_id, 0))
	_test_set_selected_weapon_level(current + delta)


func _test_set_selected_weapon_level(level: int) -> void:
	if not test_mode or test_weapon_selected_id.is_empty():
		return
	test_weapon_only_mode = true
	var next_level := clampi(level, 0, 20)
	weapon_levels[test_weapon_selected_id] = next_level
	weapon_timers[test_weapon_selected_id] = 0.0
	_clear_test_weapon_combat_artifacts()
	if next_level <= 0:
		evolved_weapons.erase(test_weapon_selected_id)
	elif next_level >= WEAPON_EVOLVE_LEVEL:
		evolved_weapons[test_weapon_selected_id] = true
	status_label.text = "Test Stage: %s Lv%d" % [_weapon_title(test_weapon_selected_id), next_level]
	_refresh_test_weapon_panel()


func _clear_test_weapon_combat_artifacts() -> void:
	projectiles.clear()
	queued_projectile_shots.clear()
	mines.clear()
	burn_zones.clear()
	nightmare_gates.clear()
	storm_tornadoes.clear()
	rune_rocks.clear()
	beams.clear()
	effects.clear()


func _test_solo_selected_weapon() -> void:
	if not test_mode or test_weapon_selected_id.is_empty():
		return
	test_weapon_panel_open = true
	test_weapon_only_mode = true
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		var weapon_id := String(def["id"])
		if HIDDEN_WEAPON_IDS.has(weapon_id):
			continue
		weapon_levels[weapon_id] = 0
		weapon_timers[weapon_id] = 0.0
	evolved_weapons.clear()
	_clear_test_weapon_combat_artifacts()
	weapon_levels[test_weapon_selected_id] = 1
	weapon_timers[test_weapon_selected_id] = 0.0
	attack_timer = max(0.1, float(stats["attack_rate"]))
	status_label.text = "Test Stage: %s 単体テスト Lv1" % _weapon_title(test_weapon_selected_id)
	_refresh_test_weapon_panel()


func _test_clear_all_weapons() -> void:
	if not test_mode:
		return
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		var weapon_id := String(def["id"])
		if HIDDEN_WEAPON_IDS.has(weapon_id):
			continue
		weapon_levels[weapon_id] = 0
		weapon_timers[weapon_id] = 0.0
	evolved_weapons.clear()
	_clear_test_weapon_combat_artifacts()
	status_label.text = "Test Stage: 全武器をLv0にしました。"
	_refresh_test_weapon_panel()


func _refresh_test_weapon_panel() -> void:
	if test_weapon_panel.get_child_count() == 0:
		return
	var list := _test_weapon_list()
	if list == null:
		return
	if test_weapon_selected_id.is_empty() and AUTO_COMBAT_WEAPON_DEFS.size() > 0:
		var first := AUTO_COMBAT_WEAPON_DEFS[0] as Dictionary
		test_weapon_selected_id = String(first["id"])

	list.clear()
	var selected_index := 0
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		var weapon_id := String(def["id"])
		if HIDDEN_WEAPON_IDS.has(weapon_id):
			continue
		var level := int(weapon_levels.get(weapon_id, 0))
		list.add_item("%s  Lv%d" % [String(def["title"]), level])
		list.set_item_metadata(list.get_item_count() - 1, weapon_id)
		if weapon_id == test_weapon_selected_id:
			selected_index = list.get_item_count() - 1
	if list.get_item_count() > 0:
		list.select(selected_index)

	var detail := _test_weapon_detail()
	if detail == null:
		return
	var selected_def := _weapon_def_by_id(test_weapon_selected_id)
	var icon := detail.get_node("IconFrame/Icon") as TextureRect
	var name := detail.get_node("Name") as Label
	var effect := detail.get_node("Effect") as Label
	var level_label := detail.get_node("Level") as Label
	icon.texture = weapon_icon_textures.get(test_weapon_selected_id, null) as Texture2D
	name.text = String(selected_def.get("title", "武器未選択"))
	effect.text = String(selected_def.get("desc", ""))
	level_label.text = "Lv%d" % int(weapon_levels.get(test_weapon_selected_id, 0))


func _test_weapon_list() -> ItemList:
	if test_weapon_panel.get_child_count() == 0:
		return null
	var box := test_weapon_panel.get_child(0) as VBoxContainer
	var body := box.get_child(1) as HBoxContainer
	return body.get_node("WeaponList") as ItemList


func _test_weapon_detail() -> VBoxContainer:
	if test_weapon_panel.get_child_count() == 0:
		return null
	var box := test_weapon_panel.get_child(0) as VBoxContainer
	var body := box.get_child(1) as HBoxContainer
	return body.get_node("Detail") as VBoxContainer


func _weapon_def_by_id(weapon_id: String) -> Dictionary:
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		if String(def["id"]) == weapon_id:
			return def
	return {}


func _test_weapon_option_selected(_index: int) -> void:
	_update_test_weapon_preview()


func _test_relic_option_selected(_index: int) -> void:
	_update_test_relic_preview()


func _test_panel_tab_changed(tab: int) -> void:
	var tabs_node := _find_child_recursive(test_panel, "Tabs")
	if tabs_node == null:
		return
	var tabs := tabs_node as TabContainer
	if tab < 0 or tab >= tabs.get_child_count():
		return
	if String(tabs.get_child(tab).name) != "武器":
		test_weapon_panel.visible = false


func _selected_test_weapon_id() -> String:
	var select := _test_option("WeaponSelect")
	if select == null or select.selected < 0:
		return ""
	return String(select.get_item_metadata(select.selected))


func _update_test_weapon_preview() -> void:
	if test_panel.get_child_count() == 0:
		return
	var preview_node := _find_child_recursive(test_panel, "WeaponPreview")
	if preview_node == null:
		return
	var preview := preview_node as PanelContainer
	var weapon_id := _selected_test_weapon_id()
	var def := _weapon_def_by_id(weapon_id)
	var level_icon := _find_child_recursive(preview, "LevelIcon") as TextureRect
	var play_icon := _find_child_recursive(preview, "PlayIcon") as TextureRect
	var name_label := _find_child_recursive(preview, "Name") as Label
	var old_name_label := _find_child_recursive(preview, "OldName") as Label
	var level_label := _find_child_recursive(preview, "Level") as Label
	var desc := _find_child_recursive(preview, "Desc") as Label
	if level_icon == null or play_icon == null or name_label == null or old_name_label == null or level_label == null or desc == null:
		return
	level_icon.texture = weapon_icon_textures.get(weapon_id, null) as Texture2D
	var play_texture := _weapon_play_texture(weapon_id)
	play_icon.texture = play_texture if play_texture != null else level_icon.texture
	name_label.text = String(def.get("title", "武器未選択"))
	old_name_label.text = "変更前: %s" % String(ORIGINAL_WEAPON_NAMES.get(weapon_id, weapon_id))
	level_label.text = "現在 Lv%d / 選択で +1" % int(weapon_levels.get(weapon_id, 0))
	var play_note := _weapon_play_preview_note(weapon_id)
	desc.text = "%s\n見え方: %s\n強化候補: %s\n%s" % [
		String(def.get("desc", "")),
		play_note,
		_weapon_growth_candidates_text(weapon_id),
		_weapon_current_stats_text(weapon_id),
	]


func _update_test_relic_preview() -> void:
	if test_panel.get_child_count() == 0:
		return
	var preview_node := _find_child_recursive(test_panel, "RelicPreview")
	if preview_node == null:
		return
	var preview := preview_node as PanelContainer
	var select := _test_option("RelicSelect")
	var icon := _find_child_recursive(preview, "RelicIcon") as TextureRect
	var name_label := _find_child_recursive(preview, "RelicName") as Label
	var rarity_label := _find_child_recursive(preview, "RelicRarity") as Label
	var desc_label := _find_child_recursive(preview, "RelicDesc") as Label
	if select == null or select.selected < 0 or icon == null or name_label == null or rarity_label == null or desc_label == null:
		return
	var relic_id := String(select.get_item_metadata(select.selected))
	var treasure := _treasure_by_id(relic_id)
	if treasure.is_empty():
		icon.texture = null
		name_label.text = "レリック未選択"
		rarity_label.text = ""
		desc_label.text = ""
		return
	icon.texture = relic_icon_textures.get(relic_id, null) as Texture2D
	name_label.text = String(treasure.get("title", relic_id))
	rarity_label.text = "レアリティ: %s / 所持数: %d" % [
		String(treasure.get("rarity", "-")),
		int(treasure_counts.get(relic_id, 0)),
	]
	desc_label.text = String(treasure.get("desc", ""))


func _weapon_play_texture(weapon_id: String) -> Texture2D:
	match weapon_id:
		"bow":
			return saint_arrow_texture
		"wireless_dagger":
			return homing_dagger_texture
		"banana":
			return rune_boomerang_texture
		"loose_rocket":
			return magic_missile_texture
		"bone":
			return bound_star_texture
		"axe":
			return crescent_axe_texture
		"dice":
			return fortune_rune_texture
		"poison_flask":
			return venom_bottle_texture
		"landmine":
			return trap_rune_texture
		"flamewalker":
			return flame_trail_texture
		"blood_scythe":
			return blood_scythe_texture
		"gravity_spike":
			return gravity_spike_texture
	return null


func _weapon_play_preview_note(weapon_id: String) -> String:
	match weapon_id:
		"aura":
			return "プレイヤー周囲に常時オーラ"
		"flamewalker", "frostwalker":
			return "足元に継続ゾーン"
		"katana", "dexecutioner", "sword", "corrupted_sword", "hero_sword":
			return "斬撃エフェクト"
		"aegis":
			return "周囲衝撃波"
		"lightning_staff":
			return "敵頭上から単体落雷"
		"black_hole":
			return "敵を引き寄せる闇の渦"
		"blood_magic":
			return "赤い範囲魔法"
		"tornado":
			return "竜巻の範囲攻撃"
		"dragon_breath":
			return "前方ブレス"
		"gravity_spike":
			return "槍落下後に黒い棘が発生"
		"blood_scythe":
			return "前方を大きく薙ぎ払う"
		"bow", "wireless_dagger", "banana", "loose_rocket", "bone", "axe", "dice", "poison_flask", "landmine":
			return "専用画像つき"
	return "仮の武器弾エフェクト"


func _test_grant_selected_weapon() -> void:
	if not test_mode:
		return
	var select := _test_option("WeaponSelect")
	if select == null:
		return
	var weapon_id := String(select.get_item_metadata(select.selected))
	_track_weapon_upgrade(weapon_id)
	status_label.text = "Test Stage: %s Lv%d" % [_weapon_title(weapon_id), int(weapon_levels.get(weapon_id, 0))]
	if test_weapon_panel_open:
		test_weapon_selected_id = weapon_id
		_refresh_test_weapon_panel()
	_update_test_weapon_preview()
	_burst(player_pos, Color(0.64, 0.9, 1.0, 0.72), 20)


func _test_grant_selected_relic() -> void:
	if not test_mode:
		return
	var select := _test_option("RelicSelect")
	if select == null:
		return
	var relic_id := String(select.get_item_metadata(select.selected))
	var treasure := _treasure_by_id(relic_id)
	if treasure.is_empty():
		return
	_apply_treasure(treasure, player_pos)
	status_label.text = "Test Stage: %s を取得" % String(treasure["title"])
	_update_test_relic_preview()


func _test_spawn_selected_item() -> void:
	if not test_mode:
		return
	var select := _test_option("ItemSelect")
	if select == null:
		return
	var kind := String(select.get_item_metadata(select.selected))
	var value := 1
	if kind == "xp":
		value = 3
	elif kind == "gold":
		value = 5
	elif kind == "meat":
		value = 20
	_spawn_loot_item(player_pos + Vector2(0.0, -80.0), kind, value, 36.0)
	status_label.text = "Test Stage: %s を出現" % kind


func _test_option(name: String) -> OptionButton:
	if test_panel.get_child_count() == 0:
		return null
	var box := test_panel.get_child(0) as VBoxContainer
	var node := _find_child_recursive(box, name)
	if node == null:
		return null
	return node as OptionButton


func _find_child_recursive(root: Node, node_name: String) -> Node:
	if root.name == node_name:
		return root
	for child in root.get_children():
		var found := _find_child_recursive(child, node_name)
		if found != null:
			return found
	return null


func _treasure_by_id(relic_id: String) -> Dictionary:
	for entry in TREASURE_DEFS:
		var treasure := entry as Dictionary
		if String(treasure["id"]) == relic_id:
			return treasure
	return {}


func _test_toggle_invincible(enabled: bool) -> void:
	invincible_mode = enabled
	_update_test_invincible_button()
	status_label.text = "Test Stage: 無敵 %s" % ("ON" if invincible_mode else "OFF")


func _test_toggle_enemy_invincible(enabled: bool) -> void:
	enemy_invincible_mode = enabled
	_update_test_enemy_invincible_button()
	status_label.text = "Test Stage: 敵無敵 %s" % ("ON" if enemy_invincible_mode else "OFF")


func _update_test_invincible_button() -> void:
	if test_panel.get_child_count() == 0:
		return
	var box := test_panel.get_child(0) as VBoxContainer
	var node := _find_child_recursive(box, "Invincible")
	if node == null:
		return
	var button := node as Button
	button.set_pressed_no_signal(invincible_mode)
	button.text = "無敵: %s" % ("ON" if invincible_mode else "OFF")


func _update_test_enemy_invincible_button() -> void:
	if test_panel.get_child_count() == 0:
		return
	var box := test_panel.get_child(0) as VBoxContainer
	var node := _find_child_recursive(box, "EnemyInvincible")
	if node == null:
		return
	var button := node as Button
	button.set_pressed_no_signal(enemy_invincible_mode)
	button.text = "敵無敵: %s" % ("ON" if enemy_invincible_mode else "OFF")


func _apply_chaos_tome(multiplier: float = 1.0) -> void:
	var options: Array[String] = ["damage", "speed", "magnet", "projectiles", "crit_chance", "luck", "duration", "projectile_speed"]
	var key: String = options[rng.randi_range(0, options.size() - 1)]
	match key:
		"damage":
			stats["damage"] += 7 * multiplier
		"speed":
			stats["speed"] += 42 * multiplier
		"magnet":
			stats["magnet"] += 80.0 * multiplier
		"projectiles":
			stats["projectiles"] += maxi(1, int(round(multiplier)))
		"crit_chance":
			stats["crit_chance"] += 0.08 * multiplier
		"luck":
			stats["luck"] += 0.10 * multiplier
		"duration":
			stats["duration"] += 0.16 * multiplier
		"projectile_speed":
			stats["projectile_speed"] += 0.14 * multiplier
	status_label.text = "カオスチャーム: %s increased." % key


func _current_weapon_slots() -> int:
	return clampi(int(stash.get("weapon_slots", INITIAL_WEAPON_SLOTS)), INITIAL_WEAPON_SLOTS, MAX_WEAPON_SLOTS)


func _current_charm_slots() -> int:
	return clampi(int(stash.get("charm_slots", INITIAL_CHARM_SLOTS)), INITIAL_CHARM_SLOTS, MAX_CHARM_SLOTS)


func _active_weapon_count() -> int:
	var count := 0
	for weapon in weapon_levels.keys():
		if int(weapon_levels.get(String(weapon), 0)) > 0:
			count += 1
	return count


func _active_charm_count() -> int:
	var count := 0
	for charm in charm_levels.keys():
		if int(charm_levels.get(String(charm), 0)) > 0:
			count += 1
	return count


func _tome_upgrade_pool() -> Array[Dictionary]:
	var pool: Array[Dictionary] = [
		{"category": "チャーム", "title": "グロウチャーム", "desc": "XP獲得量アップ", "key": "xp_gain", "amount": 0.18},
		{"category": "チャーム", "title": "ラックチャーム", "desc": "運アップ", "key": "luck", "amount": 0.10},
		{"category": "チャーム", "title": "カースチャーム", "desc": "難易度と報酬効率アップ", "key": "cursed_tome", "amount": 1},
		{"category": "チャーム", "title": "カオスチャーム", "desc": "ランダムな能力が上がる", "key": "chaos_tome", "amount": 1},
		{"category": "チャーム", "title": "パワーチャーム", "desc": "武器ダメージアップ", "key": "damage", "amount": 6},
		{"category": "チャーム", "title": "クリティカルチャーム", "desc": "クリティカル率アップ", "key": "crit_chance", "amount": 0.08},
		{"category": "チャーム", "title": "ヘイストチャーム", "desc": "攻撃とスキルの発動間隔短縮", "key": "cooldown_tome", "amount": 1},
		{"category": "チャーム", "title": "ワイドチャーム", "desc": "攻撃範囲と回収範囲アップ", "key": "size_tome", "amount": 1},
		{"category": "チャーム", "title": "ガードチャーム", "desc": "防御アップ / HP回復", "key": "armor", "amount": 2},
		{"category": "チャーム", "title": "アクセルチャーム", "desc": "弾速アップ", "key": "projectile_speed", "amount": 0.14},
		{"category": "チャーム", "title": "ソーンチャーム", "desc": "接触してきた敵に反撃ダメージ", "key": "thorns", "amount": 5},
		{"category": "チャーム", "title": "ブラッドチャーム", "desc": "攻撃命中時に低確率でHP回復", "key": "lifesteal_chance", "amount": 0.05},
		{"category": "チャーム", "title": "シールドチャーム", "desc": "時間で回復するシールドを得る", "key": "shield", "amount": 18},
		{"category": "チャーム", "title": "シルバーチャーム", "desc": "獲得ゴールド量アップ", "key": "gold_gain", "amount": 0.18},
		{"category": "チャーム", "title": "エコーチャーム", "desc": "魔法弾の数アップ", "key": "projectiles", "amount": 1},
		{"category": "チャーム", "title": "ゴールドチャーム", "desc": "宝物運と獲得ゴールド量アップ", "key": "golden_tome", "amount": 1},
		{"category": "チャーム", "title": "マグネットチャーム", "desc": "回収範囲アップ", "key": "magnet", "amount": 70.0},
		{"category": "チャーム", "title": "ミラージュチャーム", "desc": "回避率アップ", "key": "evasion", "amount": 0.06},
		{"category": "チャーム", "title": "リジェネチャーム", "desc": "HP自動回復", "key": "regen", "amount": 1},
		{"category": "チャーム", "title": "ハートチャーム", "desc": "最大HPアップ / HP回復", "key": "max_hp", "amount": 20},
		{"category": "チャーム", "title": "スピードチャーム", "desc": "移動速度アップ", "key": "speed", "amount": 36},
		{"category": "チャーム", "title": "インパクトチャーム", "desc": "敵を押し返す力アップ", "key": "knockback", "amount": 0.16},
		{"category": "チャーム", "title": "クロックチャーム", "desc": "弾と設置効果の持続時間アップ", "key": "duration", "amount": 0.15},
	]
	var can_add_charm := _active_charm_count() < _current_charm_slots()
	var filtered: Array[Dictionary] = []
	for entry in pool:
		var charm := entry as Dictionary
		var charm_id := String(charm.get("key", ""))
		if int(charm_levels.get(charm_id, 0)) <= 0 and not can_add_charm:
			continue
		filtered.append(charm)
	return filtered


func _choose_upgrade(index: int) -> void:
	if index >= offered_upgrades.size():
		return
	var upgrade := offered_upgrades[index]
	var key := String(upgrade["key"])
	if key.begins_with("weapon_"):
		_apply_weapon_choice(String(upgrade["weapon"]), String(upgrade.get("stat", "")), float(upgrade.get("weapon_amount", 0.0)))
		choice_open = false
		choice_panel.visible = false
		if xp >= xp_next:
			_gain_xp(0)
		return
	var amount := _upgrade_amount(upgrade)
	if key == "cooldown_tome":
		stats["attack_rate"] = max(0.13, float(stats["attack_rate"]) - 0.035 * amount)
		stats["lightning_rate"] = max(1.25, float(stats["lightning_rate"]) - 0.25 * amount)
		stats["skill_cooldown"] = max(0.45, float(stats["skill_cooldown"]) - 0.06 * amount)
		if float(stats["mine_rate"]) > 0.0:
			stats["mine_rate"] = max(1.25, float(stats["mine_rate"]) - 0.25 * amount)
	elif key == "size_tome":
		stats["range"] += 55 * amount
		stats["magnet"] += 45.0 * amount
		stats["area_size"] += 0.08 * amount
	elif key == "cursed_tome":
		stats["difficulty"] += 0.12 * amount
		stats["xp_gain"] += 0.10 * amount
		stats["gold_gain"] += 0.10 * amount
	elif key == "chaos_tome":
		_apply_chaos_tome(amount)
	elif key == "golden_tome":
		stats["luck"] += 0.06 * amount
		stats["gold_gain"] += 0.14 * amount
	elif key == "xp_gain" or key == "luck" or key == "frost_chance" or key == "crit_chance" or key == "projectile_speed" or key == "lifesteal_chance" or key == "gold_gain" or key == "evasion" or key == "duration" or key == "knockback":
		stats[key] = float(stats[key]) + amount
	elif key == "damage" or key == "projectiles" or key == "range" or key == "speed" or key == "magnet" or key == "thorns" or key == "regen":
		stats[key] += amount
	elif key == "armor":
		stats["armor"] += int(round(amount))
		player_hp = min(max_hp, player_hp + 10)
	elif key == "shield":
		stats["shield"] += int(round(amount))
		player_shield = int(stats["shield"])
	elif key == "drone_count":
		stats["drone_count"] += int(round(amount))
	elif key == "drone_boost":
		stats["drone_damage"] += 3
		stats["drone_radius"] += 24.0
		if int(stats["drone_count"]) <= 0:
			stats["drone_count"] = 1
	elif key == "lightning_targets":
		stats["lightning_targets"] += int(round(amount))
	elif key == "lightning_boost":
		stats["lightning_damage"] += 10
		stats["lightning_rate"] = max(1.25, float(stats["lightning_rate"]) - 0.35)
		if int(stats["lightning_targets"]) <= 0:
			stats["lightning_targets"] = 1
	elif key == "mine_unlock":
		if int(stats["mine_damage"]) <= 0:
			stats["mine_damage"] = 38
			stats["mine_rate"] = 3.2
		else:
			stats["mine_damage"] += 12
			stats["mine_rate"] = max(1.25, float(stats["mine_rate"]) - 0.25)
	elif key == "mine_boost":
		stats["mine_damage"] += 18
		if float(stats["mine_rate"]) <= 0.0:
			stats["mine_rate"] = 3.4
		else:
			stats["mine_rate"] = max(1.25, float(stats["mine_rate"]) - 0.35)
	elif key == "max_hp":
		max_hp += int(round(amount))
		player_hp = min(max_hp, player_hp + int(round(amount)))
	else:
		stats[key] += amount
	choice_open = false
	choice_panel.visible = false
	if xp >= xp_next:
		_gain_xp(0)


func _apply_weapon_choice(weapon: String, stat_key: String = "", amount: float = 0.0) -> void:
	_track_weapon_upgrade(weapon, stat_key, amount)


func _track_weapon_upgrade(weapon: String, stat_key: String = "", amount: float = 0.0) -> void:
	if not weapon_levels.has(weapon):
		weapon_levels[weapon] = 0
		weapon_timers[weapon] = 0.0
	weapon_levels[weapon] = int(weapon_levels[weapon]) + 1
	if weapon == "aegis":
		stats["shield"] = int(stats.get("shield", 40)) + 30
		player_shield = int(stats["shield"])
	_apply_weapon_stat_bonus(weapon, stat_key, amount)
	var bonus_text := ""
	if not stat_key.is_empty() and amount > 0.0:
		bonus_text = " / %s %s" % [_upgrade_stat_label(stat_key), _weapon_bonus_value_text(stat_key, amount)]
	status_label.text = "%s Lv%d: %s%s" % [_weapon_title(weapon), int(weapon_levels[weapon]), _weapon_effect(weapon), bonus_text]
	if test_weapon_panel_open:
		test_weapon_selected_id = weapon
		_refresh_test_weapon_panel()
	_burst(player_pos, Color(0.98, 0.88, 0.3, 0.62), 24)


func _evolve_weapon(weapon: String) -> void:
	evolved_weapons[weapon] = true
	if weapon == "bolt":
		stats["damage"] += 8
		stats["projectiles"] += 1
		status_label.text = "進化: スターバースト。魔法弾が貫通する。"
	elif weapon == "drone":
		stats["drone_count"] = maxi(2, int(stats["drone_count"]) + 1)
		stats["drone_damage"] += 8
		status_label.text = "進化: クレセントリング。月刃が広く強く回る。"
	elif weapon == "lightning":
		stats["lightning_targets"] = maxi(2, int(stats["lightning_targets"]) + 1)
		stats["lightning_rate"] = max(1.2, float(stats["lightning_rate"]) - 0.6)
		status_label.text = "進化: スパークストーム。雷が敵へ連鎖する。"
	elif weapon == "mine":
		stats["mine_damage"] += 24
		if float(stats["mine_rate"]) <= 0.0:
			stats["mine_rate"] = 3.0
		else:
			stats["mine_rate"] = max(1.2, float(stats["mine_rate"]) - 0.45)
		status_label.text = "進化: ルーンバースト。爆発後に炎上床を残す。"
	_burst(player_pos, Color(0.98, 0.88, 0.3, 0.78), 42)


func _open_extraction(size: Vector2) -> void:
	extract_open = true
	extract_pos = _random_world_pos_near_player(420.0, 760.0)
	status_label.text = "脱出口が開いた。生きてたどり着け。"
	extract_button.visible = true
	_burst(extract_pos, Color(0.46, 1.0, 0.78, 0.65), 34)


func _try_extract() -> void:
	if not extract_open or run_over:
		return
	if player_pos.distance_to(extract_pos) > 92.0:
		status_label.text = "脱出するにはリフトにもっと近づく。"
		return
	run_over = true
	for key in backpack.keys():
		stash[key] += int(backpack[key])
	stash["best_value"] = max(int(stash["best_value"]), _bag_value())
	save_stash()
	_show_result(true)


func _fail_run() -> void:
	run_over = true
	player_hp = 0
	_show_result(false)


func _show_result(extracted: bool) -> void:
	result_panel.visible = true
	extract_button.visible = false
	interact_button.visible = false
	test_panel.visible = false
	var box := result_panel.get_child(0) as VBoxContainer
	var title := box.get_node("Title") as Label
	var body := box.get_node("Body") as Label
	var camp_button := box.get_node("Camp") as Button
	camp_button.visible = false
	var time_text := "%02d:%02d" % [int(float(elapsed) / 60.0), int(elapsed) % 60]
	if not EXTRACTION_ENABLED:
		title.text = "ラン終了"
		body.text = "生存時間 %s  討伐 %d  Lv%d\nスコア %d  金 %d  遺物 %d  鍵 %d  鉱石 %d" % [
			time_text, kills, player_level, _bag_value(), backpack["gold"], backpack["relics"], backpack["keys"], backpack["ore"]
		]
		return
	if extracted:
		title.text = "脱出成功"
		body.text = "持ち帰り価値: %d\n金 %d  遺物 %d  鍵 %d  鉱石 %d" % [
			_bag_value(), backpack["gold"], backpack["relics"], backpack["keys"], backpack["ore"]
		]
	else:
		title.text = "探索失敗"
		body.text = "バッグの中身は失われた。\n保管済み: 金 %d  遺物 %d  鍵 %d  鉱石 %d" % [
			stash["gold"], stash["relics"], stash["keys"], stash["ore"]
		]
	camp_button.disabled = int(stash["ore"]) < 8
	_update_start_stash()


func _buy_camp_damage() -> void:
	if int(stash["ore"]) < 8:
		return
	stash["ore"] -= 8
	stash["camp_damage"] += 1
	save_stash()
	_show_result(true)


func _update_ui() -> void:
	if not started:
		top_label.text = "武器とチャームを育ててボス撃破を狙う"
		bag_label.text = "ラン中ビルド試作中"
		status_label.text = ""
		_update_start_stash()
		return

	var invincible_text := "  無敵" if invincible_mode else ""
	var shield_text := " S%d" % player_shield if player_shield > 0 else ""
	top_label.text = "HP %d/%d%s%s  Lv%d  討伐 %d" % [player_hp, max_hp, shield_text, invincible_text, player_level, kills]
	bag_label.text = "戦利品  スコア %d  金%d 遺%d 鍵%d 鉱%d" % [
		_bag_value(), backpack["gold"], backpack["relics"], backpack["keys"], backpack["ore"]
	]
	var extract_text := "生存ラン"
	if EXTRACTION_ENABLED:
		extract_text = "脱出口 OPEN" if extract_open else "脱出口: %d体 or 残り%d秒" % [EXTRACTION_KILL_TARGET, int(max(0.0, EXTRACTION_TIME - elapsed))]
	if test_mode:
		extract_text = "テスト場"
	var build_text := _active_weapon_summary()
	var boss_text := "  守護者出現中" if boss_spawned else "  守護者まで%d秒" % int(max(0.0, BOSS_TIME - elapsed))
	if test_mode:
		boss_text = "  敵 %d" % enemies.size()
	status_label.text = "%s  %02d:%02d%s\n%s" % [extract_text, int(float(elapsed) / 60.0), int(elapsed) % 60, boss_text, build_text]


func _active_weapon_summary() -> String:
	var parts: Array[String] = []
	var active_count := 0
	for entry in AUTO_COMBAT_WEAPON_DEFS:
		var def := entry as Dictionary
		var weapon_id := String(def["id"])
		var level := int(weapon_levels.get(weapon_id, 0))
		if level <= 0:
			continue
		active_count += 1
		if parts.size() < 4:
			parts.append("%s Lv%d" % [String(def["title"]), level])
	if active_count > parts.size():
		parts.append("+%d" % (active_count - parts.size()))
	if parts.is_empty():
		return "武器なし"
	return "武器: %s" % "  ".join(parts)


func _update_start_stash() -> void:
	if start_panel.get_child_count() == 0:
		return
	var box := start_panel.get_child(0) as VBoxContainer
	var stash_label := box.get_node("Stash") as Label
	stash_label.text = "ラン中に武器・チャーム・遺物を集める\nゴール: 長く生き残り、守護者を倒す"


func _draw_background(size: Vector2) -> void:
	var image_size: Vector2 = BACKGROUND_TEXTURE.get_size()
	var scale: float = maxf(WORLD_SIZE.x / image_size.x, WORLD_SIZE.y / image_size.y)
	var draw_size: Vector2 = image_size * scale
	var world_draw_pos: Vector2 = (WORLD_SIZE - draw_size) * 0.5
	draw_texture_rect(BACKGROUND_TEXTURE, Rect2(world_draw_pos - camera_pos, draw_size), false)
	draw_rect(Rect2(Vector2.ZERO, size), Color(0.02, 0.018, 0.028, 0.34))
	draw_rect(Rect2(0, 0, size.x, 136), Color(0.02, 0.02, 0.028, 0.72))


func _draw_player() -> void:
	var texture: Texture2D = player_right_texture if player_facing_right else player_left_texture
	if texture == null:
		draw_circle(player_pos, PLAYER_RADIUS + 5.0, Color(0.0, 0.0, 0.0, 0.32))
		draw_circle(player_pos, PLAYER_RADIUS, Color(0.22, 0.76, 0.68))
		draw_circle(player_pos + Vector2(0, -7), 13.0, Color(0.82, 1.0, 0.9))
		return
	var texture_size: Vector2 = texture.get_size()
	var sprite_size: Vector2 = Vector2(PLAYER_SPRITE_HEIGHT * texture_size.x / texture_size.y, PLAYER_SPRITE_HEIGHT)
	var sprite_pos: Vector2 = player_pos - Vector2(sprite_size.x * 0.5, sprite_size.y * 0.62)
	draw_ellipse(player_pos + Vector2(0.0, 24.0), 22.0, 6.0, Color(0.0, 0.0, 0.0, 0.28))
	draw_texture_rect(texture, Rect2(sprite_pos, sprite_size), false)
	var hp_width := 54.0
	var ratio: float = clampf(float(player_hp) / float(max_hp), 0.0, 1.0)
	draw_rect(Rect2(player_pos + Vector2(-hp_width * 0.5, 31.0), Vector2(hp_width, 6.0)), Color(0.18, 0.06, 0.07))
	draw_rect(Rect2(player_pos + Vector2(-hp_width * 0.5, 31.0), Vector2(hp_width * ratio, 6.0)), Color(0.42, 0.95, 0.56))


func _draw_aegis_shield() -> void:
	var aegis_level := int(weapon_levels.get("aegis", 0))
	if aegis_level <= 0:
		return
	if player_shield <= 0:
		return
	if test_weapon_only_mode and test_weapon_selected_id != "aegis":
		return
	
	var tex := weapon_icon_textures.get("aegis", null) as Texture2D
	if tex == null:
		return
		
	var shield_count := aegis_level
	var size_mult := _weapon_stat_multiplier("aegis", "size")
	var radius := 76.0 * size_mult
	var sprite_height := 50.0 * size_mult
	var tex_size := tex.get_size()
	var sprite_size := Vector2(sprite_height * tex_size.x / tex_size.y, sprite_height)
	
	var shield_ratio := clampf(float(player_shield) / float(stats.get("shield", 40)), 0.0, 1.0)
	
	for i in shield_count:
		var angle := elapsed * 0.8 + float(i) * (TAU / float(shield_count))
		var shield_pos := player_pos + Vector2(cos(angle), sin(angle)) * radius
		
		draw_set_transform(shield_pos - camera_pos, 0.0, Vector2.ONE)
		draw_texture_rect(
			tex,
			Rect2(-sprite_size * 0.5, sprite_size),
			false,
			Color(1.0, 1.0, 1.0, 0.9 * shield_ratio)
		)
		draw_set_transform(-camera_pos)


func _draw_active_auras() -> void:
	var aura_level := int(weapon_levels.get("aura", 0))
	if aura_level <= 0:
		return
	if test_weapon_only_mode and test_weapon_selected_id != "aura":
		return
	var radius := _aura_radius(aura_level)
	var pulse := 0.5 + 0.5 * sin(elapsed * 4.0)
	var inner_radius := radius * 0.64
	var mid_radius := radius * 0.82
	var outer_color := Color(0.62, 0.90, 1.0, 0.74)
	var glow_color := Color(0.34, 0.72, 1.0, 0.16)
	draw_circle(player_pos, radius * 1.05, Color(0.20, 0.64, 1.0, 0.055 + pulse * 0.025))
	draw_arc(player_pos, radius + 4.0, 0.0, TAU, 160, glow_color, 18.0)
	draw_arc(player_pos, radius + 1.0, 0.0, TAU, 160, outer_color, 6.0)
	draw_arc(player_pos, radius - 8.0, 0.0, TAU, 160, Color(0.78, 0.96, 1.0, 0.42), 2.5)
	draw_arc(player_pos, mid_radius, 0.0, TAU, 128, Color(0.72, 0.94, 1.0, 0.46), 3.0)
	draw_arc(player_pos, inner_radius, 0.0, TAU, 128, Color(0.86, 0.98, 1.0, 0.38), 2.0)
	var wisps := 28
	for i in wisps:
		var angle := TAU * float(i) / float(wisps) + elapsed * 0.08
		var normal := Vector2(cos(angle), sin(angle))
		var base := player_pos + normal * (radius - 4.0)
		var lift := Vector2(0.0, -18.0 - 12.0 * sin(elapsed * 3.8 + float(i)))
		var side := normal.rotated(PI * 0.5) * sin(elapsed * 2.5 + float(i)) * 4.0
		draw_line(base, base + lift + side, Color(0.54, 0.82, 1.0, 0.22), 3.0)
	for i in 7:
		var angle := elapsed * 0.55 + TAU * float(i) / 7.0
		var orb_pos := player_pos + Vector2(cos(angle), sin(angle)) * inner_radius
		draw_circle(orb_pos, 4.0 + pulse * 1.2, Color(0.90, 1.0, 1.0, 0.74))


func _draw_drones() -> void:
	for pos in _drone_positions():
		draw_circle(pos, 19.0, Color(0.0, 0.0, 0.0, 0.28))
		draw_arc(pos, 16.0, drone_angle, drone_angle + PI * 1.55, 18, Color(0.55, 0.9, 1.0), 6.0)
		draw_circle(pos, 5.0, Color(0.92, 1.0, 1.0))


func _draw_projectile(projectile: Dictionary) -> void:
	var pos := projectile["pos"] as Vector2
	var prev_pos := projectile.get("prev_pos", pos) as Vector2
	var vel := projectile["vel"] as Vector2
	var dir := vel.normalized()
	var life_ratio := 1.0
	var size_mult := float(projectile.get("size", 1.0))
	
	if String(projectile.get("sprite", "")) == "dexecutioner_icon":
		var tex := weapon_icon_textures.get("dexecutioner", null) as Texture2D
		if tex != null:
			_draw_textured_projectile(pos, prev_pos, dir, life_ratio, tex, 44.0 * size_mult, Color(1.0, 0.58, 0.22, 1.0), PI * 0.25, 0.0)
		return
	if String(projectile.get("sprite", "")) == "saint_arrow" and saint_arrow_texture != null:
		_draw_textured_projectile(pos, prev_pos, dir, life_ratio, saint_arrow_texture, SAINT_ARROW_SPRITE_HEIGHT * size_mult, Color(1.0, 0.92, 0.42, 1.0), PI)
		return
	if String(projectile.get("sprite", "")) == "silver_bullet" and silver_bullet_texture != null:
		_draw_textured_projectile(pos, prev_pos, dir, life_ratio, silver_bullet_texture, SILVER_BULLET_SPRITE_HEIGHT * size_mult, Color(0.86, 0.88, 0.90, 1.0), 0.0)
		return
	if String(projectile.get("sprite", "")) == "homing_dagger" and homing_dagger_texture != null:
		_draw_textured_projectile(pos, prev_pos, dir, life_ratio, homing_dagger_texture, HOMING_DAGGER_SPRITE_HEIGHT * size_mult, Color(0.72, 0.36, 1.0, 1.0), 0.0)
		return
	if String(projectile.get("sprite", "")) == "rune_boomerang" and rune_boomerang_texture != null:
		_draw_textured_projectile(pos, prev_pos, dir, 1.0, rune_boomerang_texture, RUNE_BOOMERANG_SPRITE_HEIGHT * size_mult, Color(0.36, 0.82, 1.0, 1.0), PI * 0.5, float(projectile["spin"]), false)
		return
	if String(projectile.get("sprite", "")) == "magic_missile" and magic_missile_texture != null:
		_draw_textured_projectile(pos, prev_pos, dir, life_ratio, magic_missile_texture, MAGIC_MISSILE_SPRITE_HEIGHT * size_mult, Color(1.0, 0.26, 0.12, 1.0), 0.0)
		return
	if String(projectile.get("sprite", "")) == "bound_star" and bound_star_texture != null:
		_draw_textured_projectile(pos, prev_pos, dir, 1.0, bound_star_texture, BOUND_STAR_SPRITE_HEIGHT * size_mult, Color(1.0, 0.92, 0.28, 1.0), 0.0, float(projectile["spin"]) * 0.5)
		return
	if String(projectile.get("sprite", "")) == "crescent_axe" and crescent_axe_texture != null:
		_draw_textured_projectile(pos, prev_pos, dir, life_ratio, crescent_axe_texture, 58.0 * size_mult, Color(1.0, 0.22, 0.12, 1.0), -PI * 0.45, float(projectile["spin"]))
		return
	if String(projectile.get("sprite", "")) == "fortune_rune" and fortune_rune_texture != null:
		_draw_textured_projectile(pos, prev_pos, dir, life_ratio, fortune_rune_texture, FORTUNE_RUNE_SPRITE_HEIGHT * size_mult, Color(1.0, 0.28, 1.0, 1.0), 0.0, float(projectile["spin"]) * 0.7)
		return
	if String(projectile.get("sprite", "")) == "venom_bottle" and venom_bottle_texture != null:
		var max_life := maxf(0.01, float(projectile.get("max_life", 0.72)))
		var travel_progress := clampf(1.0 - float(projectile["life"]) / max_life, 0.0, 1.0)
		var arc_max := float(projectile.get("throw_arc_height", 52.0))
		var arc_height := sin(travel_progress * PI) * arc_max
		var prev_progress := clampf(travel_progress - 0.08, 0.0, 1.0)
		var draw_pos := pos + Vector2(0.0, -arc_height)
		var draw_prev_pos := prev_pos + Vector2(0.0, -sin(prev_progress * PI) * arc_max)
		var shadow_alpha := 0.18 + 0.14 * (1.0 - arc_height / maxf(1.0, arc_max))
		draw_ellipse(pos + Vector2(0.0, 7.0 * size_mult), 12.0 * size_mult, 3.5 * size_mult, Color(0.0, 0.0, 0.0, shadow_alpha))
		_draw_textured_projectile(draw_pos, draw_prev_pos, dir, 1.0, venom_bottle_texture, 46.0 * size_mult, Color(0.48, 1.0, 0.24, 1.0), -PI * 0.14, sin(float(projectile["spin"])) * 0.38, false)
		return
	if String(projectile.get("sprite", "")) == "flare_rod" and attack_effect_textures.has("flare_rod"):
		_draw_textured_projectile(pos, prev_pos, dir, life_ratio, attack_effect_textures["flare_rod"] as Texture2D, 72.0 * size_mult, Color(1.0, 0.32, 0.08, 1.0), 0.0)
		return
	if String(projectile.get("sprite", "")) == "rune_rock" and attack_effect_textures.has("rune_rock"):
		_draw_textured_projectile(pos, prev_pos, dir, life_ratio, attack_effect_textures["rune_rock"] as Texture2D, 58.0 * size_mult, Color(0.26, 1.0, 0.82, 1.0), 0.0, float(projectile["spin"]) * 0.35)
		return
	if String(projectile.get("sprite", "")) == "cosmic_ribbon" and attack_effect_textures.has("cosmic_ribbon"):
		_draw_textured_projectile(pos, prev_pos, dir, life_ratio, attack_effect_textures["cosmic_ribbon"] as Texture2D, 86.0 * size_mult, Color(0.48, 0.24, 1.0, 1.0), PI, sin(float(projectile["spin"])) * 0.2)
		return
	var weapon_projectile := String(projectile.get("source", "")) == "weapon"
	if weapon_projectile:
		var tail_start_weapon := pos - dir * 30.0
		draw_line(tail_start_weapon, prev_pos, Color(1.0, 0.42, 0.16, 0.12 * life_ratio), 13.0 * size_mult)
		draw_line(tail_start_weapon, pos, Color(1.0, 0.68, 0.20, 0.44 * life_ratio), 6.5 * size_mult)
		draw_line(pos - dir * 15.0, pos + dir * 7.0, Color(1.0, 0.98, 0.74, 0.86 * life_ratio), 2.4 * size_mult)
		draw_circle(pos, 8.5 * size_mult, Color(1.0, 0.48, 0.12, 0.48 * life_ratio))
		draw_circle(pos, 3.8 * size_mult, Color(1.0, 0.94, 0.62, life_ratio))
		return
	var tail_start := pos - dir * 34.0
	draw_line(tail_start, prev_pos, Color(0.18, 0.62, 1.0, 0.12 * life_ratio), 14.0 * size_mult)
	draw_line(tail_start, pos, Color(0.36, 0.88, 1.0, 0.42 * life_ratio), 7.0 * size_mult)
	draw_line(pos - dir * 16.0, pos + dir * 7.0, Color(1.0, 1.0, 1.0, 0.86 * life_ratio), 2.4 * size_mult)
	draw_circle(pos, 9.0 * size_mult, Color(0.30, 0.84, 1.0, 0.5 * life_ratio))
	draw_circle(pos, 4.0 * size_mult, Color(0.95, 1.0, 1.0, life_ratio))
	var side := dir.rotated(PI * 0.5) * (3.5 + sin(float(projectile["spin"])) * 1.3) * size_mult
	draw_line(pos - side, pos + side, Color(0.92, 1.0, 1.0, 0.72 * life_ratio), 1.6 * size_mult)


func _draw_rune_rock(rock: Dictionary) -> void:
	var pos := _rune_rock_pos(rock)
	var size_mult := float(rock.get("size", 1.0))
	var radius := 24.0 * size_mult
	if attack_effect_textures.has("rune_rock"):
		var tex := attack_effect_textures["rune_rock"] as Texture2D
		var tex_size := tex.get_size()
		var sprite_size := Vector2(radius * 2.2, radius * 2.2 * tex_size.y / tex_size.x)
		draw_set_transform(pos - camera_pos, 0.0, Vector2.ONE)
		draw_texture_rect(
			tex,
			Rect2(-sprite_size * 0.5, sprite_size),
			false,
			Color.WHITE
		)
		draw_set_transform(-camera_pos)
	else:
		draw_circle(pos, radius, Color(0.20, 0.82, 0.66, 0.95))


func _draw_textured_projectile(pos: Vector2, prev_pos: Vector2, dir: Vector2, life_ratio: float, texture: Texture2D, sprite_height: float, trail_color: Color, angle_offset: float, extra_angle: float = 0.0, draw_trail: bool = true) -> void:
	if draw_trail:
		var tail_start := pos - dir * 46.0
		draw_line(tail_start, prev_pos, Color(trail_color.r, trail_color.g, trail_color.b, 0.18 * life_ratio), 16.0)
		draw_line(tail_start, pos, Color(trail_color.r, trail_color.g, trail_color.b, 0.42 * life_ratio), 7.0)
	var texture_size := texture.get_size()
	var sprite_size := Vector2(sprite_height * texture_size.x / texture_size.y, sprite_height)
	draw_set_transform(pos - camera_pos, dir.angle() + angle_offset + extra_angle, Vector2.ONE)
	draw_texture_rect(
		texture,
		Rect2(Vector2(-sprite_size.x * 0.5, -sprite_size.y * 0.5), sprite_size),
		false,
		Color(1.0, 1.0, 1.0, life_ratio)
	)
	draw_set_transform(-camera_pos)


func _draw_enemy(enemy: Dictionary) -> void:
	var pos := enemy["pos"] as Vector2
	var radius := float(enemy["radius"])
	var elite := bool(enemy["elite"])
	var boss := bool(enemy["boss"])
	if boss and boss_dark_knight_right_texture != null and boss_dark_knight_left_texture != null:
		_draw_dark_knight_boss(enemy, pos, radius)
		return
	if not elite and not boss:
		if _draw_basic_enemy_sprite(enemy, pos, radius):
			return
	var color := Color(0.76, 0.22, 0.28) if not elite else Color(0.55, 0.25, 0.9)
	if boss:
		color = Color(0.92, 0.24, 0.12)
	var hit_alpha: float = clampf(float(enemy["hit_timer"]) / HIT_FLASH_TIME, 0.0, 1.0)
	if hit_alpha > 0.0:
		color = Color.WHITE
	draw_circle(pos, radius + 4.0, Color(0.0, 0.0, 0.0, 0.34))
	draw_circle(pos, radius, color)
	if hit_alpha <= 0.0:
		draw_circle(pos + Vector2(-radius * 0.32, -radius * 0.12), radius * 0.18, Color(1.0, 0.84, 0.54))
		draw_circle(pos + Vector2(radius * 0.32, -radius * 0.12), radius * 0.18, Color(1.0, 0.84, 0.54))
	if boss:
		draw_arc(pos, radius * 0.72, -0.2, PI + 0.2, 16, Color(0.1, 0.02, 0.03), 5.0)
	var ratio: float = clampf(float(enemy["hp"]) / float(enemy["max_hp"]), 0.0, 1.0)
	draw_rect(Rect2(pos + Vector2(-radius, radius + 7.0), Vector2(radius * 2.0, 6.0)), Color(0.14, 0.04, 0.06))
	draw_rect(Rect2(pos + Vector2(-radius, radius + 7.0), Vector2(radius * 2.0 * ratio, 6.0)), Color(0.94, 0.43, 0.28))


func _draw_dark_knight_boss(enemy: Dictionary, pos: Vector2, radius: float) -> void:
	var texture: Texture2D = boss_dark_knight_left_texture if bool(enemy["facing_right"]) else boss_dark_knight_right_texture
	var texture_size: Vector2 = texture.get_size()
	var sprite_size: Vector2 = Vector2(BOSS_DARK_KNIGHT_SPRITE_HEIGHT * texture_size.x / texture_size.y, BOSS_DARK_KNIGHT_SPRITE_HEIGHT)
	var sprite_pos: Vector2 = pos - Vector2(sprite_size.x * 0.5, sprite_size.y * 0.64)
	var pulse := 1.0 + sin(elapsed * 5.0) * 0.04
	var hit_alpha: float = clampf(float(enemy["hit_timer"]) / HIT_FLASH_TIME, 0.0, 1.0)
	var flash_alpha: float = 1.0 if hit_alpha > 0.28 else clampf(hit_alpha * 3.6, 0.0, 1.0)
	var hit := hit_alpha > 0.0
	draw_circle(pos + Vector2(0.0, -26.0), 76.0 * pulse, Color(0.04, 0.0, 0.08, 0.34))
	draw_arc(pos + Vector2(0.0, -26.0), 66.0 * pulse, elapsed * 1.2, elapsed * 1.2 + TAU * 0.68, 38, Color(0.2, 0.95, 1.0, 0.26), 4.0)
	draw_ellipse(pos + Vector2(0.0, radius * 0.86), radius * 1.55, radius * 0.36, Color(0.0, 0.0, 0.0, 0.38))
	var tint := Color(14.0, 14.0, 14.0, 1.0) if hit else Color.WHITE
	draw_texture_rect(texture, Rect2(sprite_pos, sprite_size), false, tint)
	if hit:
		draw_texture_rect(texture, Rect2(sprite_pos, sprite_size), false, Color(1.0, 1.0, 1.0, flash_alpha))
	var ratio: float = clampf(float(enemy["hp"]) / float(enemy["max_hp"]), 0.0, 1.0)
	var hp_width := 132.0
	var hp_pos := pos + Vector2(-hp_width * 0.5, radius + 24.0)
	draw_rect(Rect2(hp_pos + Vector2(-2.0, -2.0), Vector2(hp_width + 4.0, 10.0)), Color(0.02, 0.0, 0.02, 0.9))
	draw_rect(Rect2(hp_pos, Vector2(hp_width,                6.0)), Color(0.16, 0.02, 0.04))
	draw_rect(Rect2(hp_pos, Vector2(hp_width * ratio, 6.0)), Color(0.92, 0.12, 0.18))
	draw_rect(Rect2(hp_pos, Vector2(hp_width * ratio, 2.0)), Color(1.0, 0.64, 0.58))


func _draw_basic_enemy_sprite(enemy: Dictionary, pos: Vector2, radius: float) -> bool:
	var enemy_type := str(enemy.get("enemy_type", "ghost"))
	var facing_right := bool(enemy["facing_right"])
	var texture: Texture2D
	var sprite_height := ENEMY_GHOST_SPRITE_HEIGHT
	if enemy_type == "shadow_cat":
		if enemy_shadow_cat_right_texture == null or enemy_shadow_cat_left_texture == null:
			return false
		texture = enemy_shadow_cat_left_texture if facing_right else enemy_shadow_cat_right_texture
		sprite_height = ENEMY_SHADOW_CAT_SPRITE_HEIGHT
	else:
		if enemy_ghost_right_texture == null or enemy_ghost_left_texture == null:
			return false
		texture = enemy_ghost_left_texture if facing_right else enemy_ghost_right_texture
	_draw_basic_enemy_texture(enemy, pos, radius, texture, sprite_height)
	return true


func _draw_basic_enemy_texture(enemy: Dictionary, pos: Vector2, radius: float, texture: Texture2D, sprite_height: float) -> void:
	var texture_size: Vector2 = texture.get_size()
	var sprite_size: Vector2 = Vector2(sprite_height * texture_size.x / texture_size.y, sprite_height)
	var sprite_pos: Vector2 = pos - Vector2(sprite_size.x * 0.5, sprite_size.y * 0.58)
	draw_ellipse(pos + Vector2(0.0, radius * 0.72), radius * 1.05, radius * 0.28, Color(0.0, 0.0, 0.0, 0.28))
	var hit_alpha: float = clampf(float(enemy["hit_timer"]) / HIT_FLASH_TIME, 0.0, 1.0)
	var flash_alpha: float = 1.0 if hit_alpha > 0.28 else clampf(hit_alpha * 3.6, 0.0, 1.0)
	var tint := Color(14.0, 14.0, 14.0, 1.0) if hit_alpha > 0.0 else Color.WHITE
	draw_texture_rect(texture, Rect2(sprite_pos, sprite_size), false, tint)
	if hit_alpha > 0.0:
		draw_texture_rect(texture, Rect2(sprite_pos, sprite_size), false, Color(1.0, 1.0, 1.0, flash_alpha))
	var ratio: float = clampf(float(enemy["hp"]) / float(enemy["max_hp"]), 0.0, 1.0)
	draw_rect(Rect2(pos + Vector2(-radius, radius + 11.0), Vector2(radius * 2.0, 6.0)), Color(0.14, 0.04, 0.06))
	draw_rect(Rect2(pos + Vector2(-radius, radius + 11.0), Vector2(radius * 2.0 * ratio, 6.0)), Color(0.94, 0.43, 0.28))


func _draw_mine(mine: Dictionary) -> void:
	var pos := mine["pos"] as Vector2
	var armed := float(mine["armed"]) <= 0.0
	var color := Color(1.0, 0.45, 0.16) if armed else Color(0.52, 0.58, 0.62)
	if String(mine.get("sprite", "")) == "trap_rune" and trap_rune_texture != null:
		var texture_size := trap_rune_texture.get_size()
		var pulse := 1.0 + sin(elapsed * 5.0) * (0.06 if armed else 0.025)
		var sprite_size := Vector2(TRAP_RUNE_SPRITE_HEIGHT * texture_size.x / texture_size.y, TRAP_RUNE_SPRITE_HEIGHT) * pulse
		draw_circle(pos, 33.0 * pulse, Color(1.0, 0.04, 0.02, 0.22 if armed else 0.08))
		draw_texture_rect(
			trap_rune_texture,
			Rect2(pos - sprite_size * 0.5, sprite_size),
			false,
			Color(1.0, 1.0, 1.0, 0.96 if armed else 0.58)
		)
		return
	draw_circle(pos, 18.0, Color(0.0, 0.0, 0.0, 0.32))
	draw_circle(pos, 13.0, color)
	draw_arc(pos, 24.0, 0.0, TAU, 20, Color(color.r, color.g, color.b, 0.5), 3.0)


func _draw_burn_zone(zone: Dictionary) -> void:
	var pos := zone["pos"] as Vector2
	var radius := float(zone["radius"])
	var alpha := 1.0
	var color := zone.get("color", Color(1.0, 0.28, 0.08, 0.12)) as Color
	if String(zone.get("style", "zone")) == "hidden":
		return
	if String(zone.get("style", "zone")) == "flame":
		var seed := float(zone.get("seed", 0.0))
		var pulse := 0.5 + 0.5 * sin(elapsed * 5.2 + seed)
		draw_circle(pos, radius * 0.92, Color(1.0, 0.16, 0.02, 0.12 * alpha))
		draw_circle(pos, radius * 0.58, Color(1.0, 0.62, 0.08, 0.16 * alpha))
		draw_arc(pos, radius * 0.92, -elapsed * 1.5 + seed, -elapsed * 1.5 + seed + TAU * 0.82, 54, Color(1.0, 0.28, 0.02, 0.58 * alpha), maxf(2.2, radius * 0.035))
		draw_arc(pos, radius * 0.62, elapsed * 2.0 + seed, elapsed * 2.0 + seed + TAU * 0.62, 42, Color(1.0, 0.88, 0.20, 0.58 * alpha), maxf(1.6, radius * 0.022))
		for spoke in 8:
			var angle := seed + TAU * float(spoke) / 8.0
			var start := pos + Vector2(cos(angle), sin(angle)) * radius * 0.22
			var end := pos + Vector2(cos(angle), sin(angle)) * radius * (0.70 + 0.06 * pulse)
			draw_line(start, end, Color(1.0, 0.42, 0.06, 0.34 * alpha), maxf(1.5, radius * 0.017))
		for tongue in 6:
			var angle := seed + TAU * float(tongue) / 6.0 + sin(elapsed * 2.4 + float(tongue)) * 0.10
			var dir := Vector2(cos(angle), sin(angle))
			var base_pos := pos + dir * radius * 0.14
			var flame_lift := radius * (0.30 + 0.10 * sin(elapsed * 4.0 + float(tongue) * 1.7))
			var tip_pos := pos + dir * radius * (0.22 + 0.08 * pulse) + Vector2.UP * flame_lift
			var side := dir.rotated(PI * 0.5)
			var width := radius * (0.06 + 0.016 * sin(elapsed * 3.7 + float(tongue)))
			draw_polygon(
				PackedVector2Array([
					base_pos - side * width,
					tip_pos,
					base_pos + side * width,
				]),
				PackedColorArray([
					Color(1.0, 0.22, 0.02, 0.42 * alpha),
					Color(1.0, 0.92, 0.18, 0.70 * alpha),
					Color(1.0, 0.36, 0.04, 0.48 * alpha),
				])
			)
			var inner_width := width * 0.36
			draw_polygon(
				PackedVector2Array([
					base_pos - side * inner_width,
					tip_pos + Vector2.UP * radius * 0.05,
					base_pos + side * inner_width,
				]),
				PackedColorArray([
					Color(1.0, 0.72, 0.08, 0.42 * alpha),
					Color(1.0, 1.0, 0.46, 0.72 * alpha),
					Color(1.0, 0.62, 0.06, 0.42 * alpha),
				])
			)
		for i in 12:
			var angle := seed + TAU * float(i) / 12.0
			var drift := sin(elapsed * (1.8 + float(i) * 0.09) + seed + float(i) * 1.7)
			var lift := fmod(elapsed * (22.0 + float(i) * 1.6) + seed * 31.0 + float(i) * 9.0, radius * 0.58)
			var spark_radius := radius * (0.24 + 0.46 * drift)
			var spark_pos := pos + Vector2(cos(angle) * spark_radius, sin(angle) * spark_radius - lift * 0.62)
			var spark_size := 1.4 + 1.8 * (0.5 + 0.5 * sin(elapsed * 7.0 + float(i)))
			draw_circle(spark_pos, spark_size * 1.2, Color(1.0, 0.26, 0.02, 0.22 * alpha))
			draw_circle(spark_pos, spark_size * 0.8, Color(1.0, 0.86, 0.14, 0.62 * alpha))
		for ember in 5:
			var ember_t := fmod(elapsed * 2.2 + float(ember) * 0.18 + seed, 1.0)
			var ember_angle := seed * 1.3 + TAU * float(ember) / 5.0
			var ember_pos := pos + Vector2(cos(ember_angle), sin(ember_angle)) * radius * (0.24 + 0.48 * ember_t) + Vector2.UP * radius * ember_t * 0.38
			draw_line(ember_pos + Vector2.DOWN * radius * 0.10, ember_pos + Vector2.UP * radius * 0.12, Color(1.0, 0.50, 0.04, 0.50 * alpha * (1.0 - ember_t)), maxf(1.4, radius * 0.018))
		return
	if String(zone.get("style", "zone")) == "frost":
		var seed := float(zone.get("seed", 0.0))
		var pulse := 0.5 + 0.5 * sin(elapsed * 4.2 + seed)
		draw_circle(pos, radius * 0.92, Color(0.36, 0.74, 1.0, 0.10 * alpha))
		draw_circle(pos, radius * 0.58, Color(0.82, 0.96, 1.0, 0.16 * alpha))
		draw_arc(pos, radius * 0.92, -elapsed * 1.3 + seed, -elapsed * 1.3 + seed + TAU * 0.82, 54, Color(0.48, 0.9, 1.0, 0.56 * alpha), maxf(2.2, radius * 0.035))
		draw_arc(pos, radius * 0.62, elapsed * 1.8 + seed, elapsed * 1.8 + seed + TAU * 0.64, 42, Color(1.0, 1.0, 1.0, 0.62 * alpha), maxf(1.6, radius * 0.022))
		for spoke in 8:
			var angle := seed + TAU * float(spoke) / 8.0
			var start := pos + Vector2(cos(angle), sin(angle)) * radius * 0.22
			var end := pos + Vector2(cos(angle), sin(angle)) * radius * (0.74 + 0.08 * pulse)
			draw_line(start, end, Color(0.74, 0.94, 1.0, 0.38 * alpha), maxf(1.6, radius * 0.018))
			var branch_dir := Vector2(cos(angle), sin(angle))
			var branch_pos := pos + branch_dir * radius * 0.56
			var branch_side := branch_dir.rotated(PI * 0.5)
			draw_line(branch_pos, branch_pos - branch_dir * radius * 0.08 + branch_side * radius * 0.08, Color(0.9, 1.0, 1.0, 0.34 * alpha), maxf(1.2, radius * 0.012))
			draw_line(branch_pos, branch_pos - branch_dir * radius * 0.08 - branch_side * radius * 0.08, Color(0.9, 1.0, 1.0, 0.34 * alpha), maxf(1.2, radius * 0.012))
		for shard in 14:
			var shard_angle := seed + elapsed * 0.7 + TAU * float(shard) / 14.0
			var shard_radius := radius * (0.18 + 0.72 * fmod(float(shard) * 0.37 + elapsed * 0.16 + seed, 1.0))
			var shard_pos := pos + Vector2(cos(shard_angle), sin(shard_angle)) * shard_radius
			var shard_size := maxf(2.0, radius * (0.018 + 0.012 * sin(elapsed * 5.4 + float(shard))))
			draw_circle(shard_pos, shard_size * 1.8, Color(0.4, 0.86, 1.0, 0.14 * alpha))
			draw_circle(shard_pos, shard_size, Color(0.92, 1.0, 1.0, 0.68 * alpha))
		for crystal in 6:
			var angle := seed * 1.7 + TAU * float(crystal) / 6.0
			var center := pos + Vector2(cos(angle), sin(angle)) * radius * 0.82
			var dir := Vector2(cos(angle), sin(angle))
			var side := dir.rotated(PI * 0.5)
			var h := radius * (0.16 + 0.04 * sin(elapsed * 3.2 + float(crystal)))
			var w := radius * 0.045
			var points := PackedVector2Array([
				center + dir * h,
				center + side * w,
				center - dir * h * 0.55,
				center - side * w,
			])
			draw_polygon(points, PackedColorArray([Color(0.86, 1.0, 1.0, 0.74 * alpha), Color(0.42, 0.82, 1.0, 0.46 * alpha), Color(0.2, 0.52, 0.9, 0.36 * alpha), Color(0.58, 0.94, 1.0, 0.52 * alpha)]))
		return
	draw_circle(pos, radius, Color(color.r, color.g, color.b, maxf(color.a, 0.12) * alpha))
	draw_arc(pos, radius * 0.72, elapsed * 1.8, elapsed * 1.8 + TAU * 0.72, 30, Color(color.r, color.g, color.b, 0.46 * alpha), 5.0)


func _draw_beam(beam: Dictionary) -> void:
	var from_pos := beam["from"] as Vector2
	var to_pos := beam["to"] as Vector2
	var ratio := 1.0
	var color := beam.get("color", Color(0.78, 0.92, 1.0, 1.0)) as Color
	var width := float(beam.get("width", 7.0))
	draw_line(from_pos, to_pos, Color(color.r, color.g, color.b, color.a * ratio), width)
	draw_line(from_pos, to_pos, Color(1.0, 1.0, 1.0, ratio), 2.0)


func _staged_animation_progress(progress: float) -> float:
	var t := clampf(progress, 0.0, 1.0)
	if t < 0.16:
		return smoothstep(0.0, 0.16, t) * 0.18
	if t < 0.74:
		return lerpf(0.18, 0.82, (t - 0.16) / 0.58)
	return lerpf(0.82, 1.0, smoothstep(0.74, 1.0, t))


func _draw_smooth_sheet_frame(tex: Texture2D, dest: Rect2, sheet_frames: int, start_frame: int, frame_count: int, frame_pos: float, alpha: float = 1.0, residual: bool = true, loop: bool = false) -> void:
	if tex == null or sheet_frames <= 0 or frame_count <= 0:
		return
	var tex_size := tex.get_size()
	var frame_size := Vector2(tex_size.x / float(sheet_frames), tex_size.y)
	var local_pos := clampf(frame_pos, 0.0, float(frame_count - 1))
	if loop:
		local_pos = fposmod(frame_pos, float(frame_count))
	var local_frame := int(floor(local_pos))
	var local_next_frame := mini(frame_count - 1, local_frame + 1)
	if loop:
		local_next_frame = (local_frame + 1) % frame_count
	var blend := smoothstep(0.0, 1.0, clampf(local_pos - floor(local_pos), 0.0, 1.0))
	if residual:
		var prev_local_frame := local_frame - 1
		if loop and prev_local_frame < 0:
			prev_local_frame = frame_count - 1
		if prev_local_frame >= 0:
			var prev_frame := start_frame + prev_local_frame
			draw_texture_rect_region(
				tex,
				dest,
				Rect2(Vector2(frame_size.x * float(prev_frame), 0.0), frame_size),
				Color(1.0, 1.0, 1.0, alpha * 0.16 * (1.0 - blend * 0.45))
			)
	var frame := start_frame + local_frame
	var next_frame := start_frame + local_next_frame
	draw_texture_rect_region(
		tex,
		dest,
		Rect2(Vector2(frame_size.x * float(frame), 0.0), frame_size),
		Color(1.0, 1.0, 1.0, alpha * (1.0 - blend))
	)
	if next_frame != frame and blend > 0.0:
		draw_texture_rect_region(
			tex,
			dest,
			Rect2(Vector2(frame_size.x * float(next_frame), 0.0), frame_size),
			Color(1.0, 1.0, 1.0, alpha * blend)
		)


func _draw_effect(effect: Dictionary) -> void:
	var kind := str(effect.get("kind", "particle"))
	var pos := effect["pos"] as Vector2
	var color := effect["color"] as Color
	if kind == "ring":
		var radius := float(effect["radius"])
		var style := String(effect.get("style", "simple"))
		var width := float(effect.get("width", 3.0))
		if style == "nightmare_gate" and nightmare_gate_texture != null:
			var max_life := maxf(0.01, float(effect.get("max_life", effect["life"])))
			var effect_age := max_life - float(effect["life"])
			var fade_in := smoothstep(0.0, 0.12, effect_age)
			var alpha: float = clampf(color.a, 0.0, 1.0) * fade_in
			var sprite_size := Vector2(radius * 1.48, radius * 2.68)
			var frame_pos := effect_age * 18.0
			draw_set_transform(pos - camera_pos, 0.0, Vector2.ONE)
			_draw_smooth_sheet_frame(
				nightmare_gate_texture,
				Rect2(-sprite_size * 0.5, sprite_size),
				NIGHTMARE_GATE_FRAME_COUNT,
				0,
				NIGHTMARE_GATE_FRAME_COUNT,
				frame_pos,
				alpha,
				true,
				true
			)
			draw_set_transform(-camera_pos)
		elif style == "void":
			draw_circle(pos, radius * 0.72, Color(color.r, color.g, color.b, color.a * 0.16))
			draw_arc(pos, radius, elapsed * 2.2, elapsed * 2.2 + TAU * 0.78, 42, color, width)
			draw_arc(pos, radius * 0.62, -elapsed * 1.6, -elapsed * 1.6 + TAU * 0.58, 32, Color(1.0, 0.86, 1.0, color.a * 0.55), maxf(2.0, width * 0.45))
		elif style == "rune":
			draw_arc(pos, radius, 0.0, TAU, 42, color, width)
			draw_arc(pos, radius * 0.68, elapsed * 1.5, elapsed * 1.5 + TAU * 0.55, 28, Color(1.0, 1.0, 1.0, color.a * 0.5), maxf(1.6, width * 0.36))
			for i in 6:
				var angle := elapsed * 1.2 + TAU * float(i) / 6.0
				draw_circle(pos + Vector2(cos(angle), sin(angle)) * radius, maxf(2.0, width * 0.55), Color(1.0, 1.0, 1.0, color.a * 0.62))
		else:
			draw_arc(pos, radius, 0.0, TAU, 32, color, width)
	elif kind == "storm_tornado":
		var radius := float(effect["radius"])
		var alpha: float = clampf(color.a, 0.0, 1.0)
		var phase := float(effect.get("phase", 0.0)) + elapsed * 8.5
		var dir := (effect.get("dir", Vector2.RIGHT) as Vector2).normalized()
		var side := Vector2.RIGHT
		var up := Vector2.UP
		var height := radius * 2.35
		var lean := clampf(dir.x, -1.0, 1.0) * radius * 0.22
		var base := pos + Vector2(0.0, radius * 0.72)
		var top := base + Vector2(lean, -height)
		draw_ellipse(base + Vector2(0.0, radius * 0.08), radius * 0.26, radius * 0.06, Color(0.0, 0.0, 0.0, 0.24 * alpha))
		draw_polygon(
			PackedVector2Array([
				top + side * -radius * 0.74,
				top + side * radius * 0.74,
				base + side * radius * 0.16,
				base + side * -radius * 0.16,
			]),
			PackedColorArray([
				Color(0.12, 0.46, 0.82, 0.18 * alpha),
				Color(0.12, 0.46, 0.82, 0.18 * alpha),
				Color(0.55, 0.92, 1.0, 0.035 * alpha),
				Color(0.55, 0.92, 1.0, 0.035 * alpha),
			])
		)
		draw_line(top - side * radius * 0.48, base - side * radius * 0.10, Color(0.42, 0.82, 1.0, 0.18 * alpha), maxf(1.8, radius * 0.018))
		draw_line(top + side * radius * 0.48, base + side * radius * 0.10, Color(0.42, 0.82, 1.0, 0.18 * alpha), maxf(1.8, radius * 0.018))
		for glow_layer in 4:
			var glow_t := float(glow_layer) / 3.0
			var glow_width := radius * lerpf(0.16, 0.035, glow_t)
			var glow_alpha := alpha * lerpf(0.08, 0.38, glow_t)
			draw_line(top + up * radius * 0.04, base - up * radius * 0.02, Color(0.72, 0.96, 1.0, glow_alpha), maxf(1.2, glow_width))
		for rim in 5:
			var rim_t := float(rim) / 4.0
			var rim_center := top.lerp(base, rim_t)
			var rim_w := radius * lerpf(0.78, 0.18, pow(rim_t, 0.86))
			var rim_h := radius * lerpf(0.10, 0.035, rim_t)
			var rim_shift := side * sin(phase * 0.65 + rim_t * TAU) * radius * 0.06
			draw_arc(rim_center + rim_shift, rim_w, phase + rim_t * TAU, phase + rim_t * TAU + PI * 0.88, 20, Color(0.86, 0.98, 1.0, alpha * lerpf(0.42, 0.16, rim_t)), maxf(1.4, rim_h * 0.34))
		for layer in 13:
			var layer_ratio := float(layer) / 12.0
			var center := top.lerp(base, layer_ratio)
			var body_w := radius * lerpf(0.72, 0.12, pow(layer_ratio, 0.86))
			var body_h := radius * lerpf(0.075, 0.030, layer_ratio)
			var swirl := sin(phase * 0.8 + layer_ratio * TAU * 2.4)
			var line_alpha := alpha * lerpf(0.72, 0.28, layer_ratio)
			var left := center - side * body_w * (0.66 + 0.18 * swirl)
			var right := center + side * body_w * (0.66 - 0.18 * swirl)
			var lift := up * body_h * sin(phase + layer_ratio * TAU)
			draw_line(left - up * body_h * 0.9, right - up * body_h * 0.2, Color(0.08, 0.24, 0.42, line_alpha * 0.20), maxf(2.4, radius * lerpf(0.030, 0.050, layer_ratio)))
			draw_line(left + lift, right - lift, Color(0.42, 0.84, 1.0, line_alpha * 0.64), maxf(2.0, radius * lerpf(0.020, 0.042, layer_ratio)))
			draw_line(left + up * body_h * 1.8, right + up * body_h * 0.6, Color(0.92, 1.0, 1.0, line_alpha * 0.24), maxf(1.2, radius * 0.012))
		for strand in 13:
			var strand_offset := float(strand) / 12.0
			var strand_phase := phase * (0.55 + strand_offset * 0.18) + strand_offset * TAU
			var prev_point := top
			for segment in 10:
				var t := float(segment) / 9.0
				var center := top.lerp(base, t)
				var body_w := radius * lerpf(0.68, 0.08, pow(t, 0.86))
				var x := sin(strand_phase + t * TAU * 1.65) * body_w
				var y_wave := cos(strand_phase * 0.7 + t * TAU) * radius * 0.030
				var next_point := center + side * x + up * y_wave
				if segment > 0:
					var strand_alpha := alpha * lerpf(0.56, 0.20, t)
					draw_line(prev_point, next_point, Color(0.70, 0.94, 1.0, strand_alpha), maxf(1.2, radius * lerpf(0.018, 0.010, t)))
					if strand % 3 == 0:
						draw_line(prev_point + up * radius * 0.025, next_point + up * radius * 0.025, Color(1.0, 1.0, 1.0, strand_alpha * 0.42), maxf(0.9, radius * 0.007))
				prev_point = next_point
		for i in 16:
			var wind_t := fmod(elapsed * 2.8 + float(i) * 0.07 + float(effect.get("phase", 0.0)), 1.0)
			var center := top.lerp(base, wind_t)
			var wind_width := radius * lerpf(0.64, 0.10, pow(wind_t, 0.86))
			var wind_pos := center + side * wind_width * sin(phase + float(i) * 1.6)
			draw_line(wind_pos + up * radius * 0.16, wind_pos - up * radius * 0.24 + side * radius * 0.10, Color(0.7, 0.94, 1.0, alpha * 0.36), maxf(1.2, radius * 0.012))
		for spark in 14:
			var spark_t := fmod(elapsed * 3.8 + float(spark) * 0.13 + float(effect.get("phase", 0.0)), 1.0)
			var spark_center := top.lerp(base, spark_t)
			var spark_pos := spark_center + side * sin(phase * 1.3 + float(spark) * 2.1) * radius * lerpf(0.78, 0.12, spark_t)
			var spark_size := maxf(1.2, radius * lerpf(0.020, 0.010, spark_t))
			draw_circle(spark_pos, spark_size * 1.8, Color(0.38, 0.80, 1.0, alpha * 0.18))
			draw_circle(spark_pos, spark_size, Color(0.94, 1.0, 1.0, alpha * 0.62))
	elif kind == "attack_image":
		var texture_id := String(effect.get("texture", ""))
		var tex := attack_effect_textures.get(texture_id, null) as Texture2D
		if tex != null:
			var effect_age := float(effect.get("max_life", effect["life"])) - float(effect["life"])
			if effect_age < float(effect.get("visual_delay", 0.0)):
				return
			var radius := float(effect["radius"])
			var angle := float(effect.get("angle", 0.0))
			var alpha: float = clampf(color.a, 0.0, 1.0)
			var texture_size := tex.get_size()
			var sprite_size := Vector2(radius * 2.0, radius * 2.0 * texture_size.y / texture_size.x)
			var flip_x := -1.0 if bool(effect.get("flip_x", false)) else 1.0
			draw_set_transform(pos - camera_pos, angle, Vector2(flip_x, 1.0))
			draw_texture_rect(
				tex,
				Rect2(-sprite_size * 0.5, sprite_size),
				false,
				Color(1.0, 1.0, 1.0, alpha)
			)
			draw_set_transform(-camera_pos)
	elif kind == "blood_scythe":
		var tex := attack_effect_textures.get("blood_scythe", null) as Texture2D
		if tex != null:
			var rect_data := _blood_scythe_visual_rect(effect)
			var pivot := rect_data["pivot"] as Vector2
			var angle := float(rect_data["angle"])
			var alpha := clampf(color.a, 0.0, 1.0)
			var sprite_size := rect_data["size"] as Vector2
			var handle_anchor := rect_data["anchor"] as Vector2
			draw_set_transform(pivot - camera_pos, angle, Vector2.ONE)
			draw_texture_rect(
				tex,
				Rect2(-handle_anchor, sprite_size),
				false,
				Color(1.0, 1.0, 1.0, alpha)
			)
			draw_set_transform(-camera_pos)
	elif kind == "breath_sheet":
		var texture_id := String(effect.get("texture", ""))
		var tex := attack_effect_textures.get(texture_id, null) as Texture2D
		if tex != null:
			var max_life := float(effect.get("max_life", 0.38))
			var life_ratio: float = clampf(float(effect["life"]) / max_life, 0.0, 1.0)
			var progress := _staged_animation_progress(1.0 - life_ratio)
			var frame_count := int(effect.get("frames", SMOOTH_ATTACK_FRAME_COUNT))
			var frame_pos := progress * float(frame_count - 1)
			var tex_size := tex.get_size()
			var frame_size := Vector2(tex_size.x / float(frame_count), tex_size.y)
			var radius := float(effect["radius"])
			var angle := float(effect.get("angle", 0.0))
			var sprite_size := Vector2(radius * 2.28, radius * 2.28 * frame_size.y / frame_size.x)
			var alpha: float = clampf(color.a, 0.0, 1.0)
			var dest := Rect2(Vector2(-sprite_size.x * 0.14, -sprite_size.y * 0.5), sprite_size)
			draw_set_transform(pos - camera_pos, angle, Vector2.ONE)
			_draw_smooth_sheet_frame(tex, dest, frame_count, 0, frame_count, frame_pos, alpha, true, false)
			draw_set_transform(-camera_pos)
	elif kind == "trap_explosion":
		var tex := attack_effect_textures.get("trap_explosion", null) as Texture2D
		if tex != null:
			var max_life := float(effect.get("max_life", 0.54))
			var life_ratio: float = clampf(float(effect["life"]) / max_life, 0.0, 1.0)
			var progress := 1.0 - life_ratio
			var frame_count := 6
			var frame_pos := progress * float(frame_count - 1)
			var frame := mini(frame_count - 1, int(floor(frame_pos)))
			var next_frame := mini(frame_count - 1, frame + 1)
			var blend := clampf(frame_pos - float(frame), 0.0, 1.0)
			var tex_size := tex.get_size()
			var frame_size := Vector2(tex_size.x / float(frame_count), tex_size.y)
			var radius := float(effect["radius"])
			var sprite_size := Vector2(radius * 2.65, radius * 2.65 * frame_size.y / frame_size.x)
			var alpha := 1.0
			draw_texture_rect_region(
				tex,
				Rect2(pos - sprite_size * 0.5, sprite_size),
				Rect2(Vector2(frame_size.x * float(frame), 0.0), frame_size),
				Color(1.0, 1.0, 1.0, alpha * (1.0 - blend))
			)
			if next_frame != frame and blend > 0.0:
				draw_texture_rect_region(
					tex,
					Rect2(pos - sprite_size * 0.5, sprite_size),
					Rect2(Vector2(frame_size.x * float(next_frame), 0.0), frame_size),
					Color(1.0, 1.0, 1.0, alpha * blend)
				)
	elif kind == "venom_splash":
		var tex := attack_effect_textures.get("venom_splash", null) as Texture2D
		if tex != null:
			var max_life := float(effect.get("max_life", 0.62))
			var life_ratio: float = clampf(float(effect["life"]) / max_life, 0.0, 1.0)
			var progress := _staged_animation_progress(1.0 - life_ratio)
			var sheet_frames := SMOOTH_ATTACK_FRAME_COUNT
			var start_frame := int(effect.get("start_frame", 0))
			var frame_count := int(effect.get("frames", sheet_frames - start_frame))
			var frame_pos := progress * float(frame_count - 1)
			var tex_size := tex.get_size()
			var frame_size := Vector2(tex_size.x / float(sheet_frames), tex_size.y)
			var radius := float(effect["radius"])
			var sprite_size := Vector2(radius * 2.0, radius * 2.0 * frame_size.y / frame_size.x)
			var alpha := 1.0
			_draw_smooth_sheet_frame(tex, Rect2(pos - sprite_size * 0.5, sprite_size), sheet_frames, start_frame, frame_count, frame_pos, alpha, true, false)
	elif kind == "magic_missile_explosion":
		var tex := attack_effect_textures.get("magic_missile_explosion", null) as Texture2D
		if tex != null:
			var max_life := float(effect.get("max_life", 0.46))
			var life_ratio: float = clampf(float(effect["life"]) / max_life, 0.0, 1.0)
			var progress := _staged_animation_progress(1.0 - life_ratio)
			var frame_count := SMOOTH_ATTACK_FRAME_COUNT
			var frame_pos := progress * float(frame_count - 1)
			var tex_size := tex.get_size()
			var frame_size := Vector2(tex_size.x / float(frame_count), tex_size.y)
			var radius := float(effect["radius"])
			var sprite_size := Vector2(radius * 2.65, radius * 2.65 * frame_size.y / frame_size.x)
			var alpha := 1.0
			_draw_smooth_sheet_frame(tex, Rect2(pos - sprite_size * 0.5, sprite_size), frame_count, 0, frame_count, frame_pos, alpha, true, false)
	elif kind == "gravity_spike":
		var max_life := float(effect.get("max_life", 0.78))
		var age := max_life - float(effect["life"])
		var impact_time := float(effect.get("impact_time", 0.36))
		var impact_progress: float = clampf(age / impact_time, 0.0, 1.0)
		var after_impact: float = clampf((age - impact_time) / maxf(0.01, max_life - impact_time), 0.0, 1.0)
		var radius := float(effect["radius"])
		var alpha: float = 1.0
		draw_ellipse(pos + Vector2(0.0, radius * 0.10), radius * 0.62, radius * 0.13, Color(0.02, 0.0, 0.04, 0.38 * alpha))
		if gravity_spike_texture != null and age <= impact_time + 0.04:
			var drop_t := 1.0 - pow(1.0 - impact_progress, 1.15)
			var drop_height := float(effect.get("drop_height", radius * 2.9))
			var spear_tip := pos + Vector2(0.0, -drop_height * (1.0 - drop_t))
			var texture_size := gravity_spike_texture.get_size()
			var spear_height := radius * 2.35
			var spear_size := Vector2(spear_height * texture_size.x / texture_size.y, spear_height)
			var spear_center := spear_tip - Vector2(0.0, spear_size.y * 0.50)
			draw_set_transform(spear_center - camera_pos, PI, Vector2.ONE)
			draw_texture_rect(
				gravity_spike_texture,
				Rect2(-spear_size * 0.5, spear_size),
				false,
				Color(1.0, 1.0, 1.0, alpha)
			)
			draw_set_transform(-camera_pos)
		if age >= impact_time:
			var sheet := attack_effect_textures.get("gravity_spike_spikes", null) as Texture2D
			if sheet != null:
				var sheet_frame_count := int(effect.get("spike_frames", 6))
				var start_frame := int(effect.get("spike_start_frame", 0))
				var frame_count := int(effect.get("spike_visible_frames", sheet_frame_count - start_frame))
				var spike_progress := _staged_animation_progress(after_impact)
				var frame_pos := spike_progress * float(frame_count - 1)
				var tex_size := sheet.get_size()
				var frame_size := Vector2(tex_size.x / float(sheet_frame_count), tex_size.y)
				var sprite_size := Vector2(radius * 2.75, radius * 2.75 * frame_size.y / frame_size.x)
				var dest := Rect2(pos - Vector2(sprite_size.x * 0.5, sprite_size.y * 0.72), sprite_size)
				_draw_smooth_sheet_frame(sheet, dest, sheet_frame_count, start_frame, frame_count, frame_pos, alpha, false, false)
			else:
				draw_circle(pos, radius * 0.46, Color(0.02, 0.0, 0.04, 0.42))
	elif kind == "lightning":
		var ratio := 1.0
		var h := float(effect.get("height", 300.0))
		var seed := float(effect.get("seed", 0.0))
		var start := pos + Vector2(sin(seed * 2.1) * 18.0, -h)
		var points: Array[Vector2] = []
		var steps := 7
		for i in range(steps + 1):
			var t := float(i) / float(steps)
			var p := start.lerp(pos, t)
			var jitter: float = sin(seed * 7.7 + float(i) * 2.35) * (18.0 * (1.0 - abs(t - 0.52)))
			if i != 0 and i != steps:
				p.x += jitter
			points.append(p)
		for i in range(points.size() - 1):
			draw_line(points[i], points[i + 1], Color(0.18, 0.64, 1.0, 0.42 * ratio), 12.0)
			draw_line(points[i], points[i + 1], Color(0.62, 0.92, 1.0, 0.78 * ratio), 6.0)
			draw_line(points[i], points[i + 1], Color(1.0, 1.0, 1.0, ratio), 2.2)
		for i in range(2, points.size() - 1, 2):
			var branch_base := points[i]
			for side in [-1.0, 1.0]:
				var branch_len := h * (0.12 + 0.035 * float(i))
				var branch_angle: float = -PI * 0.5 + side * (0.72 + 0.16 * sin(seed + float(i)))
				var mid := branch_base + Vector2.RIGHT.rotated(branch_angle) * branch_len * 0.55
				var end := branch_base + Vector2.RIGHT.rotated(branch_angle + side * 0.22) * branch_len
				draw_line(branch_base, mid, Color(0.30, 0.78, 1.0, 0.44 * ratio), 4.0)
				draw_line(mid, end, Color(0.92, 1.0, 1.0, 0.74 * ratio), 1.7)
		draw_circle(pos, 34.0, Color(0.24, 0.70, 1.0, 0.18 * ratio))
		draw_arc(pos, 38.0, seed, seed + TAU, 36, Color(0.62, 0.92, 1.0, 0.56 * ratio), 3.0)
		draw_circle(pos, 8.0, Color(1.0, 1.0, 1.0, 0.86 * ratio))
	elif kind == "slash":
		var radius := float(effect["radius"])
		var angle := float(effect.get("angle", 0.0))
		var spin := float(effect.get("spin", 0.0))
		var is_gold := bool(effect.get("is_gold", false))
		var tex := katana_slash_gold_texture if is_gold else katana_slash_blue_texture
		if tex != null:
			var sprite_size := Vector2(radius * 2.2, radius * 2.2)
			var scale_vec := Vector2(-1.0, 1.0 if spin >= 0.0 else -1.0)
			draw_set_transform(pos - camera_pos, angle, scale_vec)
			draw_texture_rect(
				tex,
				Rect2(-sprite_size * 0.5, sprite_size),
				false,
				Color(1.0, 1.0, 1.0, color.a)
			)
			draw_set_transform(-camera_pos)
		else:
			var w := float(effect.get("width", 5.0))
			draw_arc(pos, radius, angle - 0.72, angle + 0.72, 18, color, w)
			draw_arc(pos, radius * 0.72, angle - 0.45, angle + 0.45, 12, Color(1.0, 1.0, 1.0, color.a * 0.72), 2.0)
			var slash_dir := Vector2.RIGHT.rotated(angle + PI * 0.5)
			var line_start := pos - slash_dir * (radius * 1.1)
			var line_end := pos + slash_dir * (radius * 1.1)
			draw_line(line_start, line_end, Color(color.r, color.g, color.b, color.a * 0.42), w * 1.6)
			draw_line(line_start, line_end, Color(1.0, 1.0, 1.0, color.a * 0.88), w * 0.32)
	elif kind == "streak":
		var vel := effect.get("vel", Vector2.ZERO) as Vector2
		var dir := vel.normalized()
		draw_line(pos - dir * float(effect.get("length", 18.0)), pos, color, float(effect.get("width", 3.0)))
	elif kind == "float_text":
		var text := String(effect.get("text", ""))
		var font_size := int(effect.get("size", 15))
		var shadow := Color(0.02, 0.015, 0.03, minf(0.72, color.a))
		draw_string(ThemeDB.fallback_font, pos + Vector2(2.0, 2.0), text, HORIZONTAL_ALIGNMENT_CENTER, 96.0, font_size, shadow)
		draw_string(ThemeDB.fallback_font, pos, text, HORIZONTAL_ALIGNMENT_CENTER, 96.0, font_size, color)
	else:
		draw_circle(pos, float(effect["radius"]), color)


func _draw_interactable(interactable: Dictionary) -> void:
	var pos := interactable["pos"] as Vector2
	var kind := String(interactable["kind"])
	var pulse := 1.0 + sin(elapsed * 3.0 + float(interactable["pulse"])) * 0.06
	var draw_kind := kind
	if kind == "reward_chest":
		draw_kind = "chest"
	if kind == "altar" and bool(interactable.get("used", false)):
		draw_kind = "altar_used"
		pulse = 1.0
	var texture := interactable_textures.get(draw_kind, null) as Texture2D
	if texture != null:
		var texture_size := texture.get_size()
		var sprite_height := float(INTERACTABLE_SPRITE_HEIGHTS.get(draw_kind, 74.0)) * pulse
		var sprite_size := Vector2(sprite_height * texture_size.x / texture_size.y, sprite_height)
		var sprite_pos := pos - Vector2(sprite_size.x * 0.5, sprite_size.y * 0.62)
		var aura_color := Color(1.0, 0.76, 0.22, 0.14)
		if draw_kind == "locked_chest":
			aura_color = Color(0.42, 0.74, 1.0, 0.18)
		elif draw_kind == "pot":
			aura_color = Color(0.7, 0.24, 1.0, 0.16)
		elif draw_kind == "altar":
			aura_color = Color(0.62, 0.18, 1.0, 0.22)
		elif draw_kind == "altar_used":
			aura_color = Color(0.38, 0.34, 0.44, 0.10)
		draw_circle(pos + Vector2(0.0, -10.0), sprite_height * 0.48, aura_color)
		draw_ellipse(pos + Vector2(0.0, sprite_height * 0.28), sprite_height * 0.34, sprite_height * 0.09, Color(0.0, 0.0, 0.0, 0.3))
		draw_texture_rect(texture, Rect2(sprite_pos, sprite_size), false)
		return
	if kind == "altar":
		draw_circle(pos, 38.0 * pulse, Color(0.45, 0.08, 0.62, 0.24))
		draw_polygon(PackedVector2Array([
			pos + Vector2(0, -34),
			pos + Vector2(30, 22),
			pos + Vector2(-30, 22),
		]), PackedColorArray([Color(0.62, 0.18, 0.86), Color(0.62, 0.18, 0.86), Color(0.62, 0.18, 0.86)]))
		draw_circle(pos, 10.0, Color(1.0, 0.7, 1.0))
		return
	if kind == "pot":
		draw_circle(pos, 30.0 * pulse, Color(0.8, 0.62, 0.42, 0.16))
		draw_rect(Rect2(pos + Vector2(-18, -18), Vector2(36, 38)), Color(0.56, 0.38, 0.25))
		draw_rect(Rect2(pos + Vector2(-22, -24), Vector2(44, 12)), Color(0.78, 0.58, 0.34))
		draw_arc(pos + Vector2(0, 1), 18.0, 0.15, PI - 0.15, 16, Color(0.24, 0.12, 0.08), 3.0)
		return
	if kind == "merchant":
		draw_circle(pos, 40.0 * pulse, Color(0.34, 0.18, 0.72, 0.20))
		draw_ellipse(pos + Vector2(0.0, 20.0), 28.0, 7.0, Color(0.0, 0.0, 0.0, 0.28))
		draw_rect(Rect2(pos + Vector2(-28, -2), Vector2(56, 28)), Color(0.32, 0.18, 0.12))
		draw_rect(Rect2(pos + Vector2(-31, -9), Vector2(62, 10)), Color(0.58, 0.36, 0.16))
		draw_polygon(PackedVector2Array([
			pos + Vector2(-20, -8),
			pos + Vector2(0, -36),
			pos + Vector2(20, -8),
		]), PackedColorArray([Color(0.18, 0.12, 0.32), Color(0.30, 0.16, 0.58), Color(0.18, 0.12, 0.32)]))
		draw_circle(pos + Vector2(0, -8), 11.0, Color(0.92, 0.78, 0.62))
		draw_circle(pos + Vector2(-4, -10), 1.8, Color(0.06, 0.04, 0.04))
		draw_circle(pos + Vector2(4, -10), 1.8, Color(0.06, 0.04, 0.04))
		draw_circle(pos + Vector2(20, -18), 9.0, Color(1.0, 0.78, 0.22))
		return
	var locked := kind == "locked_chest"
	var color := Color(0.96, 0.68, 0.18) if not locked else Color(0.45, 0.75, 1.0)
	draw_circle(pos, 38.0 * pulse, Color(color.r, color.g, color.b, 0.18))
	draw_rect(Rect2(pos + Vector2(-31, -18), Vector2(62, 42)), color)
	draw_rect(Rect2(pos + Vector2(-31, -26), Vector2(62, 16)), Color(0.55, 0.28, 0.08) if not locked else Color(0.1, 0.24, 0.42))
	if locked:
		draw_circle(pos + Vector2(0, 2), 9.0, Color(0.94, 1.0, 1.0))


func _draw_opened_chest(chest: Dictionary) -> void:
	var texture := interactable_textures.get("chest_open", null) as Texture2D
	if texture == null:
		return
	var pos := chest.get("pos", Vector2.ZERO) as Vector2
	var texture_size := texture.get_size()
	var age := float(chest.get("time", 0.0))
	var pop := 1.0 + sin(clampf(age / OPENED_CHEST_POP_TIME, 0.0, 1.0) * PI) * 0.07
	var sprite_height := float(INTERACTABLE_SPRITE_HEIGHTS.get("chest_open", 78.0)) * pop
	var sprite_size := Vector2(sprite_height * texture_size.x / texture_size.y, sprite_height)
	var sprite_pos := pos - Vector2(sprite_size.x * 0.5, sprite_size.y * 0.62)
	draw_ellipse(pos + Vector2(0.0, sprite_height * 0.28), sprite_height * 0.34, sprite_height * 0.09, Color(0.0, 0.0, 0.0, 0.3))
	draw_texture_rect(texture, Rect2(sprite_pos, sprite_size), false)


func _draw_minimap(size: Vector2) -> void:
	var outer_size := Vector2(166.0, 252.0)
	var outer_pos := Vector2(size.x - outer_size.x - 18.0, 84.0)
	var outer := Rect2(outer_pos, outer_size)
	draw_rect(outer, Color(0.015, 0.018, 0.024, 0.82), true)
	draw_rect(outer, Color(0.52, 0.62, 0.76, 0.88), false, 2.0)

	var map_size := Vector2(128.0, 228.0)
	var map_pos := outer_pos + Vector2((outer_size.x - map_size.x) * 0.5, 12.0)
	var map_rect := Rect2(map_pos, map_size)
	draw_rect(map_rect, Color(0.028, 0.034, 0.046, 0.9), true)
	draw_rect(map_rect, Color(0.14, 0.18, 0.24, 0.95), false, 1.0)

	var view_top_left := _world_to_minimap(camera_pos, map_rect)
	var view_bottom_right := _world_to_minimap(camera_pos + size, map_rect)
	draw_rect(Rect2(view_top_left, view_bottom_right - view_top_left), Color(0.56, 0.74, 1.0, 0.12), true)
	draw_rect(Rect2(view_top_left, view_bottom_right - view_top_left), Color(0.56, 0.74, 1.0, 0.38), false, 1.0)

	for chest in opened_chests:
		_draw_minimap_marker(chest.get("pos", Vector2.ZERO) as Vector2, map_rect, Color(0.72, 0.50, 0.28, 0.62), 3.0, true)
	for interactable in interactables:
		var kind := String(interactable.get("kind", ""))
		var marker_pos := interactable.get("pos", Vector2.ZERO) as Vector2
		if kind == "reward_chest":
			_draw_minimap_marker(marker_pos, map_rect, Color(1.0, 0.86, 0.22, 1.0), 4.4, true)
		elif kind == "chest" or kind == "locked_chest":
			_draw_minimap_marker(marker_pos, map_rect, Color(1.0, 0.60, 0.20, 0.96), 3.8, true)
		elif kind == "merchant":
			_draw_minimap_marker(marker_pos, map_rect, Color(0.78, 0.48, 1.0, 0.96), 4.0, false)
		elif kind == "altar":
			_draw_minimap_marker(marker_pos, map_rect, Color(0.92, 0.28, 1.0, 0.96), 4.0, false)
	_draw_minimap_marker(player_pos, map_rect, Color(0.42, 0.95, 1.0, 1.0), 5.0, false)


func _world_to_minimap(pos: Vector2, map_rect: Rect2) -> Vector2:
	var ratio := Vector2(
		clampf(pos.x / WORLD_SIZE.x, 0.0, 1.0),
		clampf(pos.y / WORLD_SIZE.y, 0.0, 1.0)
	)
	return map_rect.position + ratio * map_rect.size


func _draw_minimap_marker(world_pos: Vector2, map_rect: Rect2, color: Color, radius: float, square: bool) -> void:
	var pos := _world_to_minimap(world_pos, map_rect)
	if square:
		draw_rect(Rect2(pos - Vector2(radius, radius), Vector2(radius * 2.0, radius * 2.0)), color, true)
	else:
		draw_circle(pos, radius, color)
	draw_circle(pos, radius + 2.0, Color(color.r, color.g, color.b, color.a * 0.18))


func _draw_loot(item: Dictionary) -> void:
	var pos := item["pos"] as Vector2
	var viewport_size := get_viewport_rect().size
	if pos.x < camera_pos.x - 48.0 or pos.y < camera_pos.y - 48.0 or pos.x > camera_pos.x + viewport_size.x + 48.0 or pos.y > camera_pos.y + viewport_size.y + 48.0:
		return
	var kind := String(item["kind"])
	var color := _loot_color(kind)
	var bob: float = sin(elapsed * 4.2 + float(item.get("bob", 0.0)))
	var draw_pos := pos + Vector2(0.0, bob * 3.0)
	if kind == "xp" and loot_xp_crystal_texture != null:
		var size: float = 23.0 + minf(8.0, float(item.get("value", 1)) * 1.5)
		var glow_alpha: float = 0.14 + (bob + 1.0) * 0.035
		draw_circle(draw_pos, size * 0.72, Color(0.22, 0.88, 1.0, glow_alpha))
		draw_texture_rect(loot_xp_crystal_texture, Rect2(draw_pos - Vector2(size, size) * 0.5, Vector2(size, size)), false)
		return
	if kind == "gold" and loot_coin_texture != null:
		var spin: float = abs(cos(elapsed * 7.5 + float(item.get("bob", 0.0))))
		var coin_size := Vector2(24.0 * (0.36 + spin * 0.64), 24.0)
		draw_circle(draw_pos, 14.0, Color(1.0, 0.74, 0.18, 0.10))
		draw_texture_rect(loot_coin_texture, Rect2(draw_pos - coin_size * 0.5, coin_size), false)
		return
	draw_circle(pos, 13.0, Color(0.0, 0.0, 0.0, 0.28))
	if kind == "xp":
		draw_polygon(PackedVector2Array([
			pos + Vector2(0, -12),
			pos + Vector2(10, -2),
			pos + Vector2(5, 12),
			pos + Vector2(-5, 12),
			pos + Vector2(-10, -2),
		]), PackedColorArray([color, color, color, color, color]))
	elif kind == "meat":
		draw_circle(pos + Vector2(-5, 0), 8.0, color)
		draw_circle(pos + Vector2(5, 0), 8.0, color)
		draw_rect(Rect2(pos + Vector2(-5, -4), Vector2(10, 12)), Color(0.96, 0.76, 0.58))
	elif kind == "magnet":
		draw_arc(pos, 13.0, PI * 0.15, PI * 0.85, 18, color, 5.0)
		draw_arc(pos, 13.0, PI * 1.15, PI * 1.85, 18, color, 5.0)
	elif kind == "keys":
		draw_rect(Rect2(pos - Vector2(4, 14), Vector2(8, 28)), color)
		draw_circle(pos + Vector2(0, -10), 8.0, color)
	elif kind == "relics":
		draw_polygon(PackedVector2Array([
			pos + Vector2(0, -15),
			pos + Vector2(13, 0),
			pos + Vector2(0, 15),
			pos + Vector2(-13, 0),
		]), PackedColorArray([color, color, color, color]))
	else:
		draw_circle(pos, 11.0, color)


func _draw_extraction() -> void:
	var pulse := 1.0 + sin(elapsed * 4.0) * 0.08
	draw_circle(extract_pos, 70.0 * pulse, Color(0.2, 0.95, 0.7, 0.16))
	draw_arc(extract_pos, 54.0 * pulse, 0.0, TAU, 48, Color(0.45, 1.0, 0.76), 6.0)
	draw_arc(extract_pos, 36.0 / pulse, elapsed, elapsed + TAU * 0.72, 32, Color(0.95, 0.78, 0.28), 4.0)


func _draw_hud_xp_bar(size: Vector2) -> void:
	if not started:
		return
	var bar_height := 17.0
	var ratio: float = clampf(displayed_xp_ratio, 0.0, 1.0)
	draw_rect(Rect2(Vector2.ZERO, Vector2(size.x, bar_height + 3.0)), Color(0.0, 0.0, 0.0, 0.72))
	draw_rect(Rect2(Vector2(2.0, 2.0), Vector2(size.x - 4.0, bar_height - 1.0)), Color(0.05, 0.06, 0.04, 0.96))
	var fill_width := (size.x - 6.0) * ratio
	var fill_rect := Rect2(Vector2(3.0, 3.0), Vector2(fill_width, bar_height - 3.0))
	if choice_open:
		_draw_level_up_xp_segments(fill_rect)
	else:
		draw_rect(fill_rect, Color(0.08, 0.74, 1.0))
	if fill_width > 10.0:
		draw_rect(Rect2(fill_rect.position, Vector2(fill_width, 4.0)), Color(1.0, 1.0, 1.0, 0.30))
		var head_x := fill_rect.position.x + fill_width
		var head_color := Color(0.3, 0.9, 1.0, 0.20) if not choice_open else Color(1.0, 0.92, 0.28, 0.24)
		draw_circle(Vector2(head_x, 10.0), 14.0 + sin(elapsed * 8.0) * 2.0, head_color)
	draw_rect(Rect2(Vector2(1.0, 1.0), Vector2(size.x - 2.0, bar_height + 1.0)), Color(0.9, 0.86, 0.58, 0.85), false, 2.0)
	draw_string(ThemeDB.fallback_font, Vector2(size.x - 88.0, 18.0), "LV %d" % player_level, HORIZONTAL_ALIGNMENT_RIGHT, 82.0, 16, Color(1.0, 0.98, 0.78))


func _draw_level_up_xp_segments(rect: Rect2) -> void:
	if rect.size.x <= 0.0:
		return
	var colors := [
		Color(0.06, 0.92, 0.18),
		Color(0.0, 0.86, 1.0),
		Color(0.92, 0.0, 1.0),
		Color(1.0, 0.04, 0.06),
		Color(1.0, 0.55, 0.02),
		Color(1.0, 0.96, 0.02),
	]
	var segment_width := 122.0
	var offset := fmod(level_up_fx_time * 260.0, segment_width * float(colors.size()))
	var start_x := rect.position.x - offset
	var index := 0
	while start_x < rect.position.x + rect.size.x:
		var clipped_x := maxf(start_x, rect.position.x)
		var right_x := minf(start_x + segment_width, rect.position.x + rect.size.x)
		if right_x > clipped_x:
			var c := colors[index % colors.size()] as Color
			draw_rect(Rect2(Vector2(clipped_x, rect.position.y), Vector2(right_x - clipped_x, rect.size.y)), c)
			draw_rect(Rect2(Vector2(clipped_x, rect.position.y), Vector2(right_x - clipped_x, 4.0)), Color(1.0, 1.0, 1.0, 0.28))
		start_x += segment_width
		index += 1


func _draw_level_up_backdrop(size: Vector2) -> void:
	var t: float = clampf(level_up_fx_time, 0.0, 1.0)
	var flash: float = maxf(0.0, 1.0 - t * 1.3)
	draw_rect(Rect2(Vector2.ZERO, size), Color(0.0, 0.0, 0.0, 0.42))
	var center := size * 0.5 + Vector2(0.0, -42.0)
	var radius := maxf(size.x, size.y) * 0.78
	for i in 28:
		var phase := level_up_fx_time * 4.2 + float(i) * 0.73
		var pulse := (sin(phase) + 1.0) * 0.5
		if pulse < 0.18:
			continue
		var ray_width := lerpf(TAU / 120.0, TAU / 22.0, pulse)
		var a0 := elapsed * 0.22 + float(i) * TAU / 28.0 - ray_width * 0.5
		var a1 := a0 + ray_width
		var alpha := (0.035 + pulse * 0.20) + flash * 0.12
		var color := Color(1.0, 0.88, 0.18, alpha) if i % 2 == 0 else Color(0.4, 1.0, 0.72, alpha * 0.72)
		draw_polygon(PackedVector2Array([
			center,
			center + Vector2(cos(a0), sin(a0)) * radius,
			center + Vector2(cos(a1), sin(a1)) * radius,
		]), PackedColorArray([color, color, color]))
	for i in 10:
		var phase := level_up_fx_time * 5.6 + float(i) * 1.37
		var pulse := (sin(phase) + 1.0) * 0.5
		if pulse < 0.32:
			continue
		var angle := -0.8 + float(i) * 0.18 + sin(phase * 0.6) * 0.15
		var band_width := lerpf(34.0, 96.0, pulse)
		var length := radius * lerpf(0.48, 0.95, pulse)
		var start := center + Vector2(cos(angle), sin(angle)) * 80.0
		var end := center + Vector2(cos(angle), sin(angle)) * length
		draw_line(start, end, Color(1.0, 0.94, 0.36, 0.06 + pulse * 0.16), band_width)
	draw_circle(center, 156.0 + sin(level_up_fx_time * 6.0) * 18.0, Color(1.0, 0.9, 0.24, 0.08 + flash * 0.16))
	if flash > 0.0:
		draw_rect(Rect2(Vector2.ZERO, size), Color(1.0, 0.96, 0.48, flash * 0.18))


func _draw_chest_reward_backdrop(size: Vector2) -> void:
	var t: float = clampf(chest_reward_time, 0.0, 1.0)
	var flash: float = maxf(0.0, 1.0 - t * 4.4)
	draw_rect(Rect2(Vector2.ZERO, size), Color(0.0, 0.0, 0.0, 0.50))
	var center := size * 0.5 + Vector2(0.0, -34.0)
	var radius := maxf(size.x, size.y) * 0.82
	var reward_color := Color(1.0, 0.78, 0.22, 0.72)
	if not pending_chest_reward.is_empty():
		reward_color = _treasure_color(String(pending_chest_reward.get("rarity", "common")))
	for i in 32:
		var phase := chest_reward_time * 4.8 + float(i) * 0.49
		var pulse := (sin(phase) + 1.0) * 0.5
		var ray_width := lerpf(TAU / 140.0, TAU / 24.0, pulse)
		var angle := chest_reward_time * 0.35 + float(i) * TAU / 32.0
		var color := Color(reward_color.r, reward_color.g, reward_color.b, 0.025 + pulse * 0.13 + flash * 0.08)
		draw_polygon(PackedVector2Array([
			center,
			center + Vector2(cos(angle - ray_width), sin(angle - ray_width)) * radius,
			center + Vector2(cos(angle + ray_width), sin(angle + ray_width)) * radius,
		]), PackedColorArray([color, color, color]))
	for i in 18:
		var phase := chest_reward_time * 3.6 + float(i) * 1.17
		var orbit := 120.0 + float(i % 5) * 28.0 + sin(phase) * 12.0
		var angle := chest_reward_time * (0.7 + float(i % 3) * 0.12) + float(i) * TAU / 18.0
		var p := center + Vector2(cos(angle), sin(angle * 0.84)) * orbit
		var sparkle := 2.2 + (sin(phase * 1.6) + 1.0) * 2.4
		draw_circle(p, sparkle, Color(1.0, 0.96, 0.68, 0.32 + flash * 0.25))
	draw_circle(center, 130.0 + sin(chest_reward_time * 7.0) * 12.0, Color(reward_color.r, reward_color.g, reward_color.b, 0.08 + flash * 0.16))
	if flash > 0.0:
		draw_rect(Rect2(Vector2.ZERO, size), Color(1.0, 0.92, 0.38, flash * 0.20))


func _draw_altar_relic_backdrop(size: Vector2) -> void:
	var t: float = clampf(altar_relic_choice_time, 0.0, 1.0)
	var flash: float = maxf(0.0, 1.0 - t * 3.6)
	draw_rect(Rect2(Vector2.ZERO, size), Color(0.0, 0.0, 0.0, 0.52))
	var center := size * 0.5 + Vector2(0.0, -34.0)
	var radius := maxf(size.x, size.y) * 0.84
	for i in 30:
		var phase := altar_relic_choice_time * 4.2 + float(i) * 0.57
		var pulse := (sin(phase) + 1.0) * 0.5
		var ray_width := lerpf(TAU / 150.0, TAU / 26.0, pulse)
		var angle := -altar_relic_choice_time * 0.28 + float(i) * TAU / 30.0
		var alpha := 0.025 + pulse * 0.12 + flash * 0.08
		var color := Color(0.72, 0.28, 1.0, alpha) if i % 2 == 0 else Color(1.0, 0.72, 1.0, alpha * 0.72)
		draw_polygon(PackedVector2Array([
			center,
			center + Vector2(cos(angle - ray_width), sin(angle - ray_width)) * radius,
			center + Vector2(cos(angle + ray_width), sin(angle + ray_width)) * radius,
		]), PackedColorArray([color, color, color]))
	for i in 16:
		var phase := altar_relic_choice_time * 3.8 + float(i) * 1.11
		var orbit := 104.0 + float(i % 4) * 34.0 + sin(phase) * 12.0
		var angle := -altar_relic_choice_time * (0.72 + float(i % 3) * 0.10) + float(i) * TAU / 16.0
		var p := center + Vector2(cos(angle), sin(angle * 0.90)) * orbit
		draw_circle(p, 2.4 + (sin(phase * 1.5) + 1.0) * 2.3, Color(0.94, 0.72, 1.0, 0.32 + flash * 0.22))
	draw_circle(center, 138.0 + sin(altar_relic_choice_time * 6.4) * 14.0, Color(0.72, 0.24, 1.0, 0.10 + flash * 0.14))
	if flash > 0.0:
		draw_rect(Rect2(Vector2.ZERO, size), Color(0.88, 0.52, 1.0, flash * 0.16))


func _draw_merchant_backdrop(size: Vector2) -> void:
	var t: float = clampf(merchant_choice_time, 0.0, 1.0)
	var flash: float = maxf(0.0, 1.0 - t * 3.8)
	draw_rect(Rect2(Vector2.ZERO, size), Color(0.0, 0.0, 0.0, 0.48))
	var center := size * 0.5 + Vector2(0.0, -34.0)
	var radius := maxf(size.x, size.y) * 0.80
	for i in 26:
		var phase := merchant_choice_time * 4.0 + float(i) * 0.61
		var pulse := (sin(phase) + 1.0) * 0.5
		var ray_width := lerpf(TAU / 150.0, TAU / 28.0, pulse)
		var angle := merchant_choice_time * 0.26 + float(i) * TAU / 26.0
		var alpha := 0.022 + pulse * 0.10 + flash * 0.07
		var color := Color(1.0, 0.64, 0.18, alpha) if i % 2 == 0 else Color(1.0, 0.92, 0.42, alpha * 0.70)
		draw_polygon(PackedVector2Array([
			center,
			center + Vector2(cos(angle - ray_width), sin(angle - ray_width)) * radius,
			center + Vector2(cos(angle + ray_width), sin(angle + ray_width)) * radius,
		]), PackedColorArray([color, color, color]))
	for i in 14:
		var phase := merchant_choice_time * 4.4 + float(i) * 1.23
		var orbit := 96.0 + float(i % 4) * 36.0 + sin(phase) * 10.0
		var angle := merchant_choice_time * (0.82 + float(i % 3) * 0.12) + float(i) * TAU / 14.0
		var p := center + Vector2(cos(angle), sin(angle * 0.86)) * orbit
		draw_circle(p, 2.6 + (sin(phase * 1.4) + 1.0) * 2.2, Color(1.0, 0.80, 0.26, 0.30 + flash * 0.20))
	draw_circle(center, 128.0 + sin(merchant_choice_time * 6.0) * 12.0, Color(1.0, 0.62, 0.12, 0.09 + flash * 0.12))
	if flash > 0.0:
		draw_rect(Rect2(Vector2.ZERO, size), Color(1.0, 0.78, 0.28, flash * 0.14))


func _draw_relic_hud(size: Vector2) -> void:
	if acquired_relics.is_empty():
		return
	var icon_size := 34.0
	var gap := 5.0
	var start := Vector2(18.0, 146.0)
	var max_cols: int = maxi(1, int((size.x - start.x * 2.0) / (icon_size + gap)))
	var max_rows := 3
	var max_visible := max_cols * max_rows
	var hidden_count := maxi(0, acquired_relics.size() - max_visible)
	var visible_count := mini(acquired_relics.size(), max_visible)
	draw_rect(Rect2(start - Vector2(8.0, 8.0), Vector2(float(max_cols) * (icon_size + gap) + 11.0, float(max_rows) * (icon_size + gap) + 11.0)), Color(0.02, 0.018, 0.026, 0.34))
	for i in visible_count:
		var relic_id := acquired_relics[acquired_relics.size() - visible_count + i]
		var texture := relic_icon_textures.get(relic_id, null) as Texture2D
		if texture == null:
			continue
		var col := i % max_cols
		var row := int(i / max_cols)
		var pos := start + Vector2(float(col) * (icon_size + gap), float(row) * (icon_size + gap))
		draw_rect(Rect2(pos - Vector2(2.0, 2.0), Vector2(icon_size + 4.0, icon_size + 4.0)), Color(0.0, 0.0, 0.0, 0.46))
		draw_texture_rect(texture, Rect2(pos, Vector2(icon_size, icon_size)), false)
	if hidden_count > 0:
		var text_pos := start + Vector2(float(max_cols - 1) * (icon_size + gap) + 2.0, float(max_rows - 1) * (icon_size + gap) + 21.0)
		draw_string(ThemeDB.fallback_font, text_pos, "+%d" % hidden_count, HORIZONTAL_ALIGNMENT_LEFT, 40.0, 15, Color(1.0, 0.92, 0.56))


func _loot_color(kind: String) -> Color:
	if kind == "xp":
		return Color(0.28, 0.72, 1.0)
	if kind == "meat":
		return Color(0.94, 0.18, 0.22)
	if kind == "magnet":
		return Color(0.36, 0.95, 1.0)
	if kind == "relics":
		return Color(0.86, 0.4, 1.0)
	if kind == "keys":
		return Color(0.5, 0.82, 1.0)
	if kind == "ore":
		return Color(0.58, 0.68, 0.72)
	return Color(1.0, 0.78, 0.25)


func _push_effect(effect: Dictionary) -> void:
	effects.append(effect)
	while effects.size() > MAX_EFFECTS:
		effects.remove_at(0)


func _push_beam(beam: Dictionary) -> void:
	beams.append(beam)
	while beams.size() > MAX_BEAMS:
		beams.remove_at(0)


func _spawn_ring_fx(pos: Vector2, radius: float, color: Color, grow: float = 0.0, life: float = 0.28, width: float = 4.0, style: String = "simple") -> void:
	_push_effect({
		"kind": "ring",
		"style": style,
		"pos": pos,
		"radius": radius,
		"grow": grow,
		"width": width,
		"life": life,
		"max_life": life,
		"fade": 0.0,
		"color": color,
	})


func _spawn_attack_image_fx(pos: Vector2, texture_id: String, radius: float, angle: float, life: float = 0.28, alpha: float = 0.82, spin: float = 0.0, vel: Vector2 = Vector2.ZERO, fade: float = 2.6, grow: float = -1.0, spin_duration: float = -1.0) -> void:
	var effect := {
		"kind": "attack_image",
		"texture": texture_id,
		"pos": pos,
		"radius": radius,
		"grow": radius * 0.55 if grow < 0.0 else grow,
		"angle": angle,
		"spin": spin,
		"life": life,
		"max_life": life,
		"fade": 0.0,
		"color": Color(1.0, 1.0, 1.0, alpha),
	}
	if spin_duration >= 0.0:
		effect["spin_duration"] = spin_duration
	if vel != Vector2.ZERO:
		effect["vel"] = vel
	_push_effect(effect)


func _spawn_curse_blade_slash(pos: Vector2, radius: float, flip_x: bool, delay: float, hit_enemy_id: int = -1, damage: int = 0, weapon_id: String = "") -> void:
	var life := 0.34 + delay
	var effect := {
		"kind": "attack_image",
		"texture": "curse_blade",
		"pos": pos,
		"radius": radius,
		"grow": 0.0,
		"angle": 0.0,
		"spin": 0.0,
		"life": life,
		"max_life": life,
		"fade": 0.0,
		"flip_x": flip_x,
		"color": Color(1.0, 1.0, 1.0, 0.92),
	}
	if delay > 0.0:
		effect["hit_delay"] = delay
		effect["visual_delay"] = delay
	if hit_enemy_id >= 0:
		effect["hit_enemy_id"] = hit_enemy_id
		effect["damage"] = damage
		effect["weapon_id"] = weapon_id
		effect["hit_done"] = false
	_push_effect(effect)


func _spawn_flare_breath_fx(pos: Vector2, radius: float, angle: float, life: float) -> void:
	_push_effect({
		"kind": "breath_sheet",
		"texture": "flare_breath",
		"pos": pos,
		"radius": radius,
		"grow": 0.0,
		"angle": angle,
		"frames": SMOOTH_ATTACK_FRAME_COUNT,
		"life": life,
		"max_life": life,
		"fade": 0.0,
		"color": Color(1.0, 1.0, 1.0, 1.0),
	})


func _spawn_storm_tornado_fx(pos: Vector2, radius: float, dir: Vector2, life: float, vel: Vector2) -> void:
	_push_effect({
		"kind": "storm_tornado",
		"pos": pos,
		"radius": radius,
		"grow": 0.0,
		"dir": dir,
		"vel": vel,
		"phase": rng.randf_range(0.0, TAU),
		"life": life,
		"max_life": life,
		"fade": 0.0,
		"color": Color(0.72, 0.95, 1.0, 1.0),
	})


func _spawn_trap_explosion_fx(pos: Vector2, radius: float) -> void:
	var life := 0.54
	_push_effect({
		"kind": "trap_explosion",
		"pos": pos,
		"radius": radius,
		"grow": 0.0,
		"life": life,
		"max_life": life,
		"fade": 0.0,
		"color": Color.WHITE,
	})


func _spawn_venom_splash_fx(pos: Vector2, radius: float, damage: int = 0, damage_radius: float = 0.0, damage_color: Color = Color(0.48, 1.0, 0.24, 0.5), zone_life: float = 0.0, weapon_id: String = "") -> void:
	var life := 0.34
	var effect := {
		"kind": "venom_splash",
		"pos": pos,
		"radius": radius,
		"grow": 0.0,
		"start_frame": 5,
		"frames": 1,
		"life": life,
		"max_life": life,
		"fade": 0.0,
		"color": Color.WHITE,
	}
	if damage > 0:
		effect["damage"] = damage
		effect["damage_radius"] = damage_radius if damage_radius > 0.0 else radius
		effect["damage_color"] = damage_color
		effect["damage_delay"] = 0.13
		effect["zone_life"] = zone_life
		effect["weapon_id"] = weapon_id
	_push_effect(effect)


func _spawn_magic_missile_explosion_fx(pos: Vector2, radius: float) -> void:
	var life := 0.46
	_push_effect({
		"kind": "magic_missile_explosion",
		"pos": pos,
		"radius": radius,
		"grow": 0.0,
		"life": life,
		"max_life": life,
		"fade": 0.0,
		"color": Color.WHITE,
	})


func _spawn_slash_fx(pos: Vector2, radius: float, angle: float, color: Color, life: float = 0.22, width: float = 6.0) -> void:
	_push_effect({
		"kind": "slash",
		"pos": pos,
		"radius": radius,
		"grow": radius * 0.9,
		"angle": angle,
		"spin": rng.randf_range(-1.4, 1.4),
		"width": width,
		"life": life,
		"fade": 0.0,
		"color": color,
	})


func _spawn_streak_fx(pos: Vector2, dir: Vector2, color: Color, speed: float, length: float, width: float, life: float) -> void:
	_push_effect({
		"kind": "streak",
		"pos": pos,
		"vel": dir.normalized() * speed,
		"length": length,
		"width": width,
		"life": life,
		"fade": 0.0,
		"color": color,
	})


func _spawn_flame_step_fx(pos: Vector2, _dir: Vector2, radius: float) -> void:
	for i in 14:
		var angle := TAU * float(i) / 14.0 + rng.randf_range(-0.16, 0.16)
		var spark_dir := Vector2(cos(angle), sin(angle))
		var spark_pos := pos + spark_dir * rng.randf_range(radius * 0.42, radius * 0.72)
		var drift_dir := (spark_dir * 0.35 + Vector2.UP).normalized()
		_spawn_streak_fx(
			spark_pos,
			drift_dir,
			Color(1.0, rng.randf_range(0.46, 0.78), 0.08, rng.randf_range(0.56, 0.82)),
			rng.randf_range(28.0, 72.0),
			rng.randf_range(6.0, 15.0),
			rng.randf_range(1.3, 3.0),
			rng.randf_range(0.28, 0.55)
		)
		if i % 3 == 0:
			_push_effect({
				"kind": "particle",
				"pos": spark_pos + spark_dir * rng.randf_range(4.0, 14.0),
				"vel": drift_dir * rng.randf_range(22.0, 58.0),
				"radius": rng.randf_range(2.2, 5.4),
				"grow": rng.randf_range(2.0, 8.0),
				"life": rng.randf_range(0.34, 0.62),
				"fade": 0.0,
				"color": Color(1.0, 0.9, 0.22, rng.randf_range(0.54, 0.78)),
			})


func _spawn_beam_fx(from_pos: Vector2, to_pos: Vector2, color: Color, life: float = 0.16, width: float = 7.0) -> void:
	_push_beam({
		"from": from_pos,
		"to": to_pos,
		"life": life,
		"max_life": life,
		"color": color,
		"width": width,
	})


func _burst(pos: Vector2, color: Color, count: int) -> void:
	var capped_count := mini(count, 42)
	for i in capped_count:
		_push_effect({
			"kind": "particle",
			"pos": pos + Vector2(rng.randf_range(-12.0, 12.0), rng.randf_range(-12.0, 12.0)),
			"radius": rng.randf_range(4.0, 12.0),
			"grow": rng.randf_range(12.0, 36.0),
			"life": rng.randf_range(0.22, 0.42),
			"color": color,
		})


func _muzzle_flash(origin: Vector2, dir: Vector2) -> void:
	_spawn_ring_fx(origin + dir * 18.0, 5.0, Color(0.65, 0.95, 1.0, 0.72), 66.0, 0.16, 3.0)
	_spawn_slash_fx(origin + dir * 24.0, 22.0, dir.angle(), Color(0.88, 1.0, 1.0, 0.66), 0.16, 4.0)


func _weapon_muzzle_flash(origin: Vector2, dir: Vector2, sprite: String = "") -> void:
	if sprite == "rune_boomerang" or sprite == "venom_bottle" or sprite == "magic_missile":
		return
	if test_weapon_only_mode and sprite.is_empty():
		_spawn_ring_fx(origin + dir * 18.0, 5.0, Color(1.0, 0.62, 0.18, 0.62), 56.0, 0.14, 3.0)
		_spawn_slash_fx(origin + dir * 24.0, 20.0, dir.angle(), Color(1.0, 0.86, 0.36, 0.58), 0.14, 4.0)
		return
	var color := Color(1.0, 0.74, 0.24, 0.66)
	if sprite == "magic_missile":
		color = Color(1.0, 0.32, 0.18, 0.66)
	elif sprite == "homing_dagger" or sprite == "rune_boomerang":
		color = Color(0.74, 0.42, 1.0, 0.66)
	elif sprite == "saint_arrow":
		color = Color(1.0, 0.94, 0.42, 0.66)
	elif sprite == "venom_bottle":
		color = Color(0.48, 1.0, 0.26, 0.62)
	_spawn_ring_fx(origin + dir * 18.0, 5.0, color, 62.0, 0.15, 3.0)
	_spawn_slash_fx(origin + dir * 24.0, 22.0, dir.angle(), color.lightened(0.18), 0.15, 4.0)


func _hit_spark(pos: Vector2, dir: Vector2, damage: int) -> void:
	_spawn_ring_fx(pos, 6.0, Color(0.55, 0.92, 1.0, 0.78), 92.0, 0.2, 4.0)
	_spawn_slash_fx(pos, 18.0 + minf(float(damage), 28.0) * 0.55, dir.angle() + PI * 0.5, Color(0.96, 1.0, 1.0, 0.74), 0.18, 5.0)
	for i in 7:
		var spark_dir := dir.rotated(rng.randf_range(-1.8, 1.8))
		_spawn_streak_fx(pos + spark_dir * rng.randf_range(2.0, 10.0), spark_dir, Color(0.72, 0.96, 1.0, 0.72), rng.randf_range(80.0, 190.0), rng.randf_range(8.0, 18.0), rng.randf_range(1.6, 3.2), rng.randf_range(0.16, 0.28))


func _spawn_damage_number(pos: Vector2, damage: int, crit: bool, radius: float = 16.0) -> void:
	var color := Color(0.88, 0.98, 1.0, 0.95)
	var size := 16
	var drift := Vector2(rng.randf_range(-10.0, 10.0), -58.0)
	var head_pos := pos + Vector2(0.0, -radius - 14.0)
	if crit:
		color = Color(1.0, 0.48, 0.08, 1.0)
		size = 23
		drift = Vector2(rng.randf_range(-14.0, 14.0), -72.0)
	_push_effect({
		"kind": "float_text",
		"pos": head_pos + Vector2(rng.randf_range(-8.0, 8.0), rng.randf_range(-6.0, 4.0)),
		"vel": drift,
		"life": 0.56 if not crit else 0.68,
		"color": color,
		"fade": 1.25,
		"text": "%d" % damage,
		"size": size,
	})


func _death_burst(pos: Vector2, elite: bool, boss: bool) -> void:
	var color := Color(1.0, 0.78, 0.32, 0.8)
	var count := 12
	if elite:
		color = Color(0.96, 0.5, 1.0, 0.82)
		count = 22
	if boss:
		color = Color(1.0, 0.24, 0.12, 0.9)
		count = 42
	_spawn_ring_fx(pos, 10.0, color, 148.0 if boss else (112.0 if elite else 86.0), 0.32, 6.0 if boss else 4.0, "rune" if boss or elite else "simple")
	_burst(pos, color, count)


func load_stash() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) != OK:
		return
	for key in stash.keys():
		stash[key] = int(cfg.get_value("stash", key, stash[key]))


func save_stash() -> void:
	var cfg := ConfigFile.new()
	for key in stash.keys():
		cfg.set_value("stash", key, stash[key])
	cfg.save(SAVE_PATH)
