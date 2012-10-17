Ext.define('MoveIn.view.Nav', {
    extend: 'Ext.navigation.View',
    alias: "widget.nav",
    config: {
		fullscreen: true,
		defaultBackButtonText: "返回",
		useTitleForBackButtonText: true,
		items: [
			{  
				xtype: 'panel',
				title: '登录',
				scrollable: {
					direction: 'vertical'
				},
				defaults: {
					labelWidth: '35%'
				},
				items: [
					{
						title: '',
						html: "<div align='center' style='width:100%;padding-top:30px;'><img src='http://mobile.sugon.com/view/png/dflogo.png'/></div>"
					},
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
							}
						]  
					},  
					{  
						xtype: 'button',  
						text: '登录', 
						ui: "confirm",
						id: "btn_login"
					}
				]  
			}
		]
    }
});