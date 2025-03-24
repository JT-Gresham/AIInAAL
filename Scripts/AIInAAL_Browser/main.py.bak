import sys
import os

from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5.QtCore import *
from PyQt5.QtWebEngineWidgets import *

argurl = sys.argv[1]
#homepage = "http://github.com/JT-Gresham/AIInAAL"

class OCDBrowser(QMainWindow):

        def __init__(self, *args, **kwargs):
                super(OCDBrowser, self).__init__(*args, **kwargs)

                self.window = QWidget()
                self.window.setWindowTitle("OCD Browser")

                self.layout = QVBoxLayout()
                self.horizontal = QHBoxLayout()

                self.url_bar = QTextEdit()
                self.url_bar.setMaximumHeight(30)

                self.go_btn = QPushButton("GO")
                self.go_btn.setMinimumHeight(30)

                self.back_btn = QPushButton("<")
                self.back_btn.setMinimumHeight(30)

                self.forward_btn = QPushButton(">")
                self.forward_btn.setMinimumHeight(30)

                self.horizontal.addWidget(self.url_bar)
                self.horizontal.addWidget(self.go_btn)
                self.horizontal.addWidget(self.back_btn)
                self.horizontal.addWidget(self.forward_btn)

                self.browser = QWebEngineView()

                self.layout.addLayout(self.horizontal)
                self.layout.addWidget(self.browser)

                self.browser.setUrl(QUrl(argurl))

                self.window.setLayout(self.layout)
                self.window.show()

app = QApplication([])
window = OCDBrowser()
app.exec_()
