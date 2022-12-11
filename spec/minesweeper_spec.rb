require './minesweeper'
require './mines'

RSpec.describe 'Minesweeper' do
  describe '.start' do
    context 'クリアできなかった場合' do
      it '爆弾があったことを示す文字列が出力され、ゲームが中断される' do
        allow(Mines).to receive(:rand).and_return(0, 0, 1, 1)
  
        allow(ARGF).to receive(:gets).and_return(StringIO.new('1,1').gets)
  
        expected_stdout = <<~EOS
  マインスイーパを開始します。
  爆弾は全部で2個あります。
  回答を入力してください。(例: 1,1)
  ■ ■ ■
  ■ ■ ■
  ■ ■ ■
  爆弾です。
  マインスイーパを終了します。
        EOS
  
        expect { Minesweeper.start }.to output(expected_stdout).to_stdout
      end
    end

    context 'クリアできた場合' do
      it  'マスがすべて開き、正常にゲームが終了する' do
        allow(Mines).to receive(:rand).and_return(0, 0, 1, 1)
  
        allow(ARGF).to receive(:gets).and_return(
          StringIO.new('1,2').gets,
          StringIO.new('1,3').gets,
          StringIO.new('2,1').gets,
          StringIO.new('2,3').gets,
          StringIO.new('3,1').gets,
          StringIO.new('3,2').gets,
          StringIO.new('3,3').gets,
        )
  
        expected_stdout = <<~EOS
  マインスイーパを開始します。
  爆弾は全部で2個あります。
  回答を入力してください。(例: 1,1)
  ■ ■ ■
  ■ ■ ■
  ■ ■ ■
  ---
  次の回答を入力してください。
  ---
  ■ 2 ■
  ■ ■ ■
  ■ ■ ■
  ---
  次の回答を入力してください。
  ---
  ■ 2 1
  ■ ■ ■
  ■ ■ ■
  ---
  次の回答を入力してください。
  ---
  ■ 2 1
  2 ■ ■
  ■ ■ ■
  ---
  次の回答を入力してください。
  ---
  ■ 2 1
  2 ■ 1
  ■ ■ ■
  ---
  次の回答を入力してください。
  ---
  ■ 2 1
  2 ■ 1
  1 ■ ■
  ---
  次の回答を入力してください。
  ---
  ■ 2 1
  2 ■ 1
  1 1 ■
  ---
  クリアです。
  ---
  ✖ 2 1
  2 ✖ 1
  1 1 1
  マインスイーパを終了します。
        EOS
  
        expect { Minesweeper.start }.to output(expected_stdout).to_stdout
      end
    end
  end
end
