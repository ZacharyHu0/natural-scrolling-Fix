; ================================
;Natural-Scrolling-Fix 鼠标滚轮方向修正工具
; 功能：反转滚动方向但保留缩放方向
; 版本：2.1
; 更新日期：2025-07-08
; 适用版本：AutoHotkey v2.0+
; ================================

#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"
SetWorkingDir A_ScriptDir

; 设置托盘菜单和标题
PrepareTrayMenu()

; 首次运行时设置开机自启
if !IsAutoStartEnabled() {
    SetAutoStart()
}

; 核心功能：反转滚轮方向（排除Ctrl键状态）
WheelUp:: {
    if GetKeyState("Ctrl", "P") {    ; 检测Ctrl键是否按下
        Send "{WheelUp}"             ; 缩放模式：发送原始上滚
    } else {
        Send "{WheelDown}"           ; 滚动模式：发送下滚（实现方向反转）
    }
}

WheelDown:: {
    if GetKeyState("Ctrl", "P") {
        Send "{WheelDown}"           ; 缩放模式：发送原始下滚
    } else {
        Send "{WheelUp}"             ; 滚动模式：发送上滚（实现方向反转）
    }
}

; ======================
; 功能函数
; ======================

PrepareTrayMenu() {
    ; 设置托盘图标和标题
    TraySetIcon "shell32.dll", 246  ; 使用系统图标
    A_TrayMenu.Delete()  ; 清除默认菜单
    
    ; 添加标题栏 (不可点击)
    A_TrayMenu.Add("Natural Scrolling Fix", (*) => "")
    A_TrayMenu.Disable("Natural Scrolling Fix")  ; 禁用点击
    
    ; 添加分隔线
    A_TrayMenu.Add()
    
    ; 添加功能菜单
    A_TrayMenu.Add("暂停脚本", TogglePause)
    A_TrayMenu.Add("开机自启: " . (IsAutoStartEnabled() ? "已启用" : "未启用"), ToggleAutoStart)
    A_TrayMenu.Add("退出", ExitScript)
}
    
    ; 添加分隔线
    A_TrayMenu.Add()
    
    ; 添加注释(不可点击)
    A_TrayMenu.Add("V2.1", (*) => "")
    A_TrayMenu.Disable("V2.1")  ; 禁用点击
    A_TrayMenu.Add("Author: ZacharyHu", (*) => "")
    A_TrayMenu.Disable("Author: ZacharyHu")  ; 禁用点击
    A_TrayMenu.Add("Author: ZacharyHu", (*) => "")
    A_TrayMenu.Disable("Author: ZacharyHu")  ; 禁用点击


; 检查开机自启状态
IsAutoStartEnabled() {
    try {
        ; 尝试读取注册表项
        RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "NaturalScrollingFix")
        return true  ; 读取成功表示已设置
    } catch {
        return false ; 读取失败表示未设置
    }
}

; 设置开机自启
SetAutoStart() {
    try {
        ; 获取当前EXE路径
        exePath := A_IsCompiled ? A_ScriptFullPath : A_AhkPath ' "' A_ScriptFullPath '"'
        
        ; 写入注册表
        RegWrite exePath, "REG_SZ", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "NaturalScrollingFix"
        TrayTip "开机自启已设置", "Natural Scrolling Fix 将在系统启动时自动运行", 1
        
        ; 更新菜单状态
        A_TrayMenu.Rename("开机自启: 未启用", "开机自启: 已启用")
    } catch as e {
        MsgBox "开机自启设置失败: " e.Message
    }
}

; 切换开机自启
ToggleAutoStart(*) {
    if (IsAutoStartEnabled()) {
        try {
            RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "NaturalScrollingFix"
            A_TrayMenu.Rename("开机自启: 已启用", "开机自启: 未启用")
            TrayTip "开机自启已禁用", "Natural Scrolling Fix 将不再随系统启动", 1
        } catch as e {
            MsgBox "禁用开机自启失败: " e.Message
        }
    } else {
        SetAutoStart()
    }
}

; 暂停/继续脚本
TogglePause(*) {
    static paused := false
    paused := !paused
    Pause paused
    A_TrayMenu.ToggleCheck("暂停脚本")
    TrayTip paused ? "脚本已暂停" : "脚本已恢复", "滚轮修正功能 " . (paused ? "已禁用" : "已启用"), 1
}

; 退出脚本
ExitScript(*) {
    ExitApp
}