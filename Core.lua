namespace "trit"{
	namespace "commander"{
		class "Commander"
		:inherits(trit.graphics.SmirnoffWindow)
		{
			method"Init"
			:attributes(override)
			:body(
				function(self)
					self.maxLines = 100;
					self.lineHeight = 15
					self.tabMessageLog = {}

					self:SetBackground(hsv(0,0,0.2))

					self.key = trit.input.Keyboard:new()

				end
			);

			method"Call"
			:attributes(override)
			:body(
				function(self)
					self.key:SetCondition(self:IsWindowActive())

					--self:Out(self:swIsWindowActive())
					--self:Out(self.key:Key("!"))
					--self:Out(tostring(string.byte("`")).." "..tostring(self.key:Key("`")))
				end
			);

			method"Out"
			:body(
				function(self,data)
					local str = tostring(data);
					local strBuffer
					if string.find(str, "\n") == nill then
						table.insert(self.tabMessageLog, 1, str);
						if table.getn(self.tabMessageLog)>self.maxLines then
							table.remove(self.tabMessageLog)
						end
					else
						while string.find(str, "\n") ~= nil do
							local header, footer = string.find(str, "\n")
							strBuffer = string.sub(str, footer+1)
							str = string.sub(str, 1, header-1)

							table.insert(self.tabMessageLog, 1, str);
							if table.getn(self.tabMessageLog)>self.maxLines then
								table.remove(self.tabMessageLog)
							end

							str = strBuffer
						end

						if str ~= nil then
							table.insert(self.tabMessageLog, 1, str);
							if table.getn(self.tabMessageLog)>self.maxLines then
								table.remove(self.tabMessageLog)
							end
						end
					end
					--文字列中に改行が含まれない場合
-- 					if string.find(str, "\n") == nil then
-- 						table.insert(self.tabMessageLog, 1, str);
-- 						if table.getn(self.tabMessageLog)>self.maxLines then
-- 							table.remove(self.tabMessageLog)
-- 						end
-- 					else
-- 						--文字列中に改行が含まれる場合
-- 						while string.find(str, "\n") ~= nil do
-- 							local header, footer = string.find(str, "\n")
-- 							--次に処理する文字列(改行より後)をBufferに格納
-- 							strBuffer = string.sub(str, footer+1)
-- 							--表示文字列の切り出し
-- 							str = string.sub(str, 1, header-1)
--
-- 							table.insert(self.tabMessageLog, 1, str);
-- 							if table.getn(self.tabMessageLog)>self.maxLines then
-- 								table.remove(self.tabMessageLog)
-- 							end
--
-- 							--strにBufferを代入
-- 							str = strBuffer
-- 						end
--
-- 						--最後の\nより後に文字列がある場合の処理
-- 						if str ~= nil then
-- 							table.insert(self.tabMessageLog, 1, str);
-- 							if table.getn(self.tabMessageLog)>self.maxLines then
-- 								table.remove(self.tabMessageLog)
-- 							end
-- 						end
--
-- 					end
				end
			);

			method"In"
			:body(
				function(self,data)

				end
			);




			method"Draw"
			:attributes(override)
			:body(
				function(self)
					self:SetColor(hsv(0,0,1))
					for i = 1, self.maxLines do
						if self.tabMessageLog[i] ~= nil then
							self.font(2,self.height-(i+1)*self.lineHeight,tostring(self.tabMessageLog[i]))
						end
					end

					self.brush:SetColor(hsv(0,0,0.4))
					self.brush(0,self.height-self.lineHeight,self.width,self.lineHeight)

					self:SetColor(hsv(0,0,0.3))
				end
			);

		};
	}--commander
}--trit
