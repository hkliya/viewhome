Ext.define("MoveIn.view.Login", {
    extend: "Ext.Container",
    alias: "widget.login",
    config: {  
		fullscreen: true,
		items: [
			{  
				xtype: 'toolbar',  
				docked: 'top',  
				layout: { pack: 'center' },  
				items: [  
				]
			},{  
				xtype: 'panel',
				centered: true,
				defaults: {
				// labelAlign: 'right'
					labelWidth: '35%'
				},
				items: [
					{  
						xtype: 'fieldset',  
						title: '移动办公登录',  
						instructions: '（欢迎使用移动办公系统）',  
						items: [  
							{  
								xtype: 'textfield',  
								label: '用户名'  
							},  
							{  
								xtype: 'textfield',  
								label: '密码'  
							},  
							{  
								xtype: 'textareafield',  
								label: 'Message'  
							}  
						]  
					},  
					{  
						xtype: 'button',  
						text: '登录', 
						ui: "confirm",
						id:"new-note-btn"
					}
				]  
			}
		]  
	}
});


